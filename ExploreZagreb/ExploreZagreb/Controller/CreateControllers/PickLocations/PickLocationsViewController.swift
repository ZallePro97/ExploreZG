import UIKit

protocol LocationTransitionDelegate {
    func saveLocations(locations: [LocationModel])
}

class PickLocationsViewController: UIViewController {

    private var appService: AppService!

    var dialogView: DialogView!
    var error: Bool = false

    var cardView: UIView!
    var contentView: UIView!
    var infoLabel: UILabel!
    var locationsTableView: UITableView!

    var saveLocationsButton: UIButton!

    var locations = [LocationModel]()
    var selectedLocations = [Int : LocationModel]()

    var locationDelegate: LocationTransitionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        locationsTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "cell")

        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        
        appService.getAllLocations { (locations) in
            guard let locations = locations else { return }

            self.locations = locations
            self.locationsTableView.reloadData()
        }
    }

    convenience init(appService: AppService) {
        self.init()
        self.appService = appService
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = false
    }

    func showDialog(withMessage message: String?) {
        dialogView.messageLabel.text = message
        dialogView.isHidden = false
    }

    @objc
    func dissmisView() {
        if !error {
            self.navigationController?.popViewController(animated: true)
            return
        }

        dialogView.isHidden = true
    }

    @objc
    func saveLocations() {
        var savedLocations = [LocationModel]()
        for location in selectedLocations.values {
            savedLocations.append(location)
        }

        locationDelegate?.saveLocations(locations: savedLocations)
        navigationController?.popViewController(animated: true)
    }

}

extension PickLocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationTableViewCell
        cell.setLocationCell(locationModel: locations[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationTableViewCell
        if !cell.checkMarkImageView.isHidden {
            selectedLocations.removeValue(forKey: indexPath.row)
            cell.checkMarkImageView.isHidden = true
        } else {
            selectedLocations[indexPath.row] = locations[indexPath.row]
            cell.checkMarkImageView.isHidden = false
        }
    }
}
