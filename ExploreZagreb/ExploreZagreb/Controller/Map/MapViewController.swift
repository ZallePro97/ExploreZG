import UIKit
import MapKit
import PureLayout
import CoreLocation
import ChameleonFramework

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let appService = AppService()

    var mapView: MKMapView!

    var locations = [LocationModel]()
    var dict: [String: [MKAnnotation]] = [String: [MKAnnotation]]()
    
    var annotations: [MKAnnotation] = []
    
    var locationManager: CLLocationManager!
    let regionInMeters: Double = 10000
    
    var quitButton: UIButton?
    var nextLocationButton: UIButton?
    var shortestPath: [LocationModel] = []
    var routeNumber = 0
    
    var routeSelected: Bool? {
        didSet {
            setUIForRouteDirections()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.mapView = MKMapView(frame: CGRect.zero)
        self.mapView.showsUserLocation = true

        self.locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        mapView.delegate = self

        appService.getAllLocations { [weak self] (locations) in
            guard let locations = locations else { return }

            self?.locations = locations
            self?.drawPins()
        }
        
        setUI()
        checkLocationServices()
        
//        let loc = CLLocation(latitude: 45.8150, longitude: 15.9819)
//        let region = MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
//        mapView.setRegion(mapView.regionThatFits(region), animated: true)
        
    }
    
    func setUI() {
        self.view.addSubview(mapView)
        
        setConstraints()
    }
    
    func setConstraints() {
        mapView.autoPinEdgesToSuperviewEdges()
    }
    
    @objc func nextLocationTapped(sender: UIButton) {
        routeNumber += 1
        if routeNumber >= shortestPath.count {
            quitTapped(sender: quitButton ?? UIButton(frame: CGRect.zero))
            return
        }
        
        let nextLoc = shortestPath[routeNumber]
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: CLLocationDegrees(nextLoc.latitude), longitude: CLLocationDegrees(nextLoc.longitude)), animated: true)
    }
    
    @objc func quitTapped(sender: UIButton) {
        print("Stisnuto")
        shortestPath.removeAll()
        routeNumber = 0
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.removeOverlays(self.mapView.overlays)
        }
        
        appService.getAllLocations { [weak self] (locations) in
            guard let locations = locations else { return }
            
            self?.locations = locations
            self?.drawPins()
        }
        
        if let viewWithTag = self.mapView.viewWithTag(100) {
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 0.2, animations: {viewWithTag.alpha = 0.0},
                                           completion: {(value: Bool) in
                                            viewWithTag.removeFromSuperview()
                })
                
            }
        }
        
        if let viewWithTag2 = self.mapView.viewWithTag(200) {
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 0.2, animations: {viewWithTag2.alpha = 0.0},
                               completion: {(value: Bool) in
                                viewWithTag2.removeFromSuperview()
                })
                
            }
        }
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func drawPins() {
        annotations = []

        for location in self.locations {
            let address = location.address
            let latitude = location.latitude
            let longitude = location.longitude
            let place = MKPointAnnotation()

            place.title = String(address)
            place.subtitle = location.name
            place.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            self.annotations.append(place)
        }

        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotations(self.annotations)
        }
        
    }
    

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as? MKPointAnnotation
        
        for location in self.locations {
            
            if annotation?.subtitle == location.name {
                
                let vc = PinLocationDetailsViewController()
                
                vc.location = location
                navigationController?.pushViewController(vc, animated: true)
                
                break
            }
        }
        
        mapView.deselectAnnotation(annotation, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.flatRed()
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func setUIForRouteDirections() {
        // gumb za prestanak rute
        quitButton = UIButton.newAutoLayout()
        quitButton?.tag = 100
        quitButton?.backgroundColor = .red
        quitButton?.setTitleColor(.white, for: .normal)
        quitButton?.setTitle("X", for: .normal)
        quitButton?.layer.masksToBounds = true
        quitButton?.layer.cornerRadius = 10
        quitButton?.titleLabel?.adjustsFontSizeToFitWidth = true
        quitButton?.titleLabel?.tintColor = UIColor.flatWhite()
        quitButton?.addTarget(self, action: #selector(quitTapped), for: .touchUpInside)
        quitButton?.layer.zPosition = 1
        mapView.addSubview(quitButton ?? UIButton(frame: CGRect.zero))
        quitButton?.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        quitButton?.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        // gumb za sljedecu lokaciju kad imam zeljenu rutu
        nextLocationButton = UIButton.newAutoLayout()
        nextLocationButton?.tag = 200
        nextLocationButton?.backgroundColor = UIColor.flatBlue()
        nextLocationButton?.setTitleColor(.white, for: .normal)
        nextLocationButton?.setTitle("Next Location", for: .normal)
        nextLocationButton?.layer.masksToBounds = true
        nextLocationButton?.layer.cornerRadius = 10
        nextLocationButton?.titleLabel?.adjustsFontSizeToFitWidth = true
        nextLocationButton?.addTarget(self, action: #selector(nextLocationTapped), for: .touchUpInside)
        nextLocationButton?.layer.zPosition = 1
        mapView.addSubview(nextLocationButton ?? UIButton(frame: CGRect.zero))
        nextLocationButton?.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        nextLocationButton?.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        
        // crtanje rute
        var currentLocation: CLLocation!
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locationManager.location
            
        }
        
        // pronalazak prve najblize lokacije od trenutne lokacije
        var min = 1000000
        var close: LocationModel?
        
        let curr = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        for l in locations {
            if Int(curr.distance(from: CLLocation(latitude: l.latitude, longitude: l.longitude))) < min {
                min = Int(curr.distance(from: CLLocation(latitude: l.latitude, longitude: l.longitude)))
                close = l
            }
        }
        
        if let close = close {
            mapView.setCenter(CLLocationCoordinate2D(latitude: CLLocationDegrees(close.latitude), longitude: CLLocationDegrees(close.longitude)), animated: true)
            shortestPath.append(close)
        }
        
        var startLocation = shortestPath[0]
        while shortestPath.count != locations.count {
            var min = 1000000
            var locToAdd: LocationModel?
            for loc in locations {
                let loc1 = CLLocation(latitude: startLocation.latitude, longitude: startLocation.longitude)
                let loc2 = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
                
                if !shortestPath.contains(loc) && Int(loc1.distance(from: loc2)) < min {
                    min = Int(loc1.distance(from: loc2))
                    locToAdd = loc
                }
            }
            print(locToAdd)
            if let locToAdd = locToAdd {
                shortestPath.append(locToAdd)
                startLocation = locToAdd
            }
            
        }
        
        for i in 1..<shortestPath.count {
            let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: shortestPath[i - 1].latitude, longitude: shortestPath[i - 1].longitude))
            let destinationPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: shortestPath[i].latitude, longitude: shortestPath[i].longitude))
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
            directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
            directionRequest.transportType = .walking
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate { (response, error) in
                guard let directionResonse = response else {
                    if let error = error {
                        print("we have error getting directions==\(error.localizedDescription)")
                    }
                    return
                }
                
                let route = directionResonse.routes[0]
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            }
            
        }
        
    }

}



extension MapViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
