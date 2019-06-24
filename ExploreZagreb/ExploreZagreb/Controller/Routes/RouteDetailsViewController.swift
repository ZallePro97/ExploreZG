import UIKit
import PureLayout
import MapKit
import FirebaseAuth

protocol RouteTransitionProtocol {
    func sendRouteToMap(route: RouteModel)
}

class RouteDetailsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var map_view: MKMapView!
    
    @IBOutlet weak var route_title: UILabel!
    
    @IBOutlet weak var popularity_label: UILabel!
    
    @IBOutlet weak var locations_list: UITableView!
    
    @IBOutlet weak var send_btn: UIButton!
    
    @IBOutlet weak var addToFavorites: UIButton!
    @IBOutlet weak var comments_list: UITableView!
    
    @IBOutlet weak var comment_text_view: UITextView!
    
    @IBOutlet weak var content_view: UIView!
    
    @IBOutlet weak var start_btn: UIButton!
    
    @IBAction func send_btn_clicked(_ sender: Any) {
        guard let userMail = Auth.auth().currentUser?.email else { return }
        guard comment_text_view.text.trimmingCharacters(in: .whitespaces) != "" else { return }
        
        let comment = CreateCommentModel(comment: comment_text_view.text, userMail: userMail, routeId: route_details.id)

        appService.createComment(commentModel: comment) { (comment) in
            guard let comment = comment else { return }

            self.comment_text_view.text = ""
            self.route_details.comments.append(comment)
            self.comments_list.reloadData()
        }
    }
    @IBAction func start_btn_clicked(_ sender: Any) {
        routeTransitionDelegate?.sendRouteToMap(route: route_details)
        appService.incresePopularity(forRouteId: route_details.id)

        navigationController?.popViewController(animated: true)
        previousViewController.tabBarController!.selectedIndex = 0
    }

    var routeTransitionDelegate: RouteTransitionProtocol?

    private let appService = AppService()
    
    @IBAction func like_btn_clicked(_ sender: Any) {
        var react : [String]
        if let reactions =  defaults.array(forKey: "reactions"){
            react = reactions as! [String]
        }
        else{
            react = [""]
        }

        if !react.contains("moja ruta"){
            route_details.numberOfLikes =  route_details.numberOfLikes + 1
            react.append("moja ruta")
            defaults.set(react, forKey: "reactions")
        }
        defaults.removeObject(forKey: "reactions")
        
    }
    
    @IBAction func dislike_btn_clicked(_ sender: Any) {
        var react : [String]
        if let reactions =  defaults.array(forKey: "reactions"){
            react = reactions as! [String]
        }
        else{
            react = [""]
        }
        
        if !react.contains("moja ruta"){
            route_details.numberOfDislikes =  route_details.numberOfDislikes + 1
            react.append("moja ruta")
            defaults.set(react, forKey: "reactions")
        }
        defaults.removeObject(forKey: "reactions")
    }
    
   let defaults = UserDefaults.standard
    
    let url = "https://iosquiz.herokuapp.com/api/quizzes"
        
    var route_details : RouteModel
    
    var annotations: [MKAnnotation] = []
    
    var previousViewController : UIViewController
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor != UIColor.black {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    init(routeInfo : RouteModel, previousViewController: UIViewController) {
        self.route_details = routeInfo
        self.previousViewController = previousViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func addToFavoriteAction(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser else { return }
        appService.addRouteToFavorites(userMail: user.email!, routeId: route_details.id)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        comment_text_view.delegate = self
        
        locations_list.dataSource = self
        locations_list.delegate = self
        locations_list.backgroundColor = UIColor.white
        locations_list.register(RouteDetailsCell.self, forCellReuseIdentifier: "cell")
        
        comments_list.dataSource = self
        comments_list.delegate = self
        comments_list.backgroundColor = UIColor.white
        comments_list.register(CommentCell.self, forCellReuseIdentifier: "cell")
        
        locations_list.allowsSelection = true
        
        comment_text_view.delegate = self

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        content_view.addGestureRecognizer(tap)

        appService.getRoute(routeId: route_details.id) { (routeModel) in
            guard let routeModel = routeModel else { return }

            self.route_details = routeModel
            self.setView()
            self.comments_list.reloadData()
            self.locations_list.reloadData()
        }
        
        setView()
    }
//    @objc
//    func dismissKeyboard() {
//        view.endEditing(true)
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setView(){
        
        route_title.text = route_details.name
        popularity_label.text = "popularity: " + String(route_details.popularity)
        
        start_btn.layer.cornerRadius = 10
        start_btn.clipsToBounds = true
        
        comment_text_view.layer.cornerRadius = 10
        comment_text_view.clipsToBounds = true
        
        send_btn.layer.cornerRadius = 10
        send_btn.clipsToBounds = true
        
        drawPins()

        guard route_details.locations.count != 0 else { return }
        
        let latitude = route_details.locations[0].latitude
        let longitude = route_details.locations[0].longitude
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude,longitude: longitude), latitudinalMeters: CLLocationDistance(exactly: 3500)!, longitudinalMeters: CLLocationDistance(exactly: 3500)!)
        
        map_view.setRegion(map_view.regionThatFits(region), animated: true)
    }
    
    func drawPins() {
        for location in route_details.locations {
            let address = location.address
            let latitude = location.latitude
            let longitude = location.longitude
            
            let place = MKPointAnnotation()
            place.title = String(address)
            place.subtitle = description
            place.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            self.annotations.append(place)
            
            DispatchQueue.main.async {
                self.map_view.addAnnotation(place)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView{
        case locations_list:
            return 70
        case comments_list:
            return 100
            
        default:
            return 70
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView{
        case locations_list:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RouteDetailsCell
            let locationName = route_details.locations[indexPath.row].name
            cell.locationNameLabel.text = locationName
            return cell
            
        case comments_list:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentCell
            let comment = route_details.comments[indexPath.row].comment
            cell.commentLabel.text = comment
            return cell
      
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case locations_list:
            return route_details.locations.count
            
        case comments_list:
            
            return route_details.comments.count
            
        default:
            return 1
        }
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        switch tableView {
        case locations_list:
            let latitude = route_details.locations[indexPath.row].latitude
            let longitude = route_details.locations[indexPath.row].longitude
            map_view.setCenter(CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)), animated: true)
            
        default:
            print("error")
        }
    }
    
    
    
}

extension RouteDetailsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }

        return true
    }
}






