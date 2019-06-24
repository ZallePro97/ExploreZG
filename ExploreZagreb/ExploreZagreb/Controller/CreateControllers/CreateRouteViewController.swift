import UIKit

class CreateRouteViewController: UIViewController, LocationTransitionDelegate {

    var dialogView: DialogView!
    var error: Bool = false

    var scrollView: UIScrollView!
    var cardView: UIView!
    var contentView: UIView!
    var stackView: UIStackView!

    var infoLabel: UILabel!

    var nameContainer: InputView!
    var pickerContainer: UIView!
    var categoryPickerView: UIPickerView!
    var locationContainer: UIView!
    var locationsTableView: UITableView!
    var addLocationButton: UIButton!

    var createRouteButton: UIButton!

    var pickerData = [String]()
    var locations = [LocationModel]()

    private var appService: AppService!
    private var appRouter: AppRouter!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()

        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self

        locationsTableView.delegate = self
        locationsTableView.dataSource = self

        locationsTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "cell")

        appService.getAllCategories { (categories) in
            guard let categories = categories else { return }

            self.pickerData = categories.map { $0.name }
            self.categoryPickerView.reloadAllComponents()
            self.pickerContainer.isHidden = false
        }
    }

    convenience init(appService: AppService, appRouter: AppRouter) {
        self.init()

        self.appService = appService
        self.appRouter = appRouter
    }

    @objc
    func handleCreateRoute() {
        guard let name = nameContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }

        if name.isEmpty {
            nameContainer.errorMessageContainer.isHidden = false
            return
        }

        let categoryIndex = categoryPickerView.selectedRow(inComponent: 0)
        let categoryName = pickerData[categoryIndex]
        let locationsIds = locations.map { $0.id }

        guard locationsIds.count > 2 else {
            error = true
            showDialog(withMessage: "There needs to be more then 2 selected locations!")
            return
        }

        let routeModel = CreateRouteModel(name: name, categoryName: categoryName, locationIds: locationsIds)

        appService.createRoute(routeModel: routeModel) { (routeModel) in
            self.navigationController?.popViewController(animated: true)
        }

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
    func handleAddLocations() {
        let vc = PickLocationsViewController(appService: appService)
        vc.locationDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func saveLocations(locations: [LocationModel]) {
        self.locations = locations
        locationsTableView.reloadData()
    }

}

extension CreateRouteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
    }

    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
    }
}

extension CreateRouteViewController: UITableViewDelegate, UITableViewDataSource {
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
    }
}
