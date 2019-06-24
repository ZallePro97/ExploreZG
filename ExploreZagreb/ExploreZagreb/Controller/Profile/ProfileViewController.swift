import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, EditUserProtocol {

    private var appService: AppService!
    private var appRouter: AppRouter!

    var contentView: UIView!
    var optionsButton: UIButton!

    var containerView: UIView!
    var profileImage: UIImageView!
    var usernameLabel: UILabel!
    var userInfo: UILabel!

    var favoritesLabel: UILabel!
    var favoritesTableView: UITableView!

    var multiOptionalView: MultiOptionalView!

    var routes = [RouteModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()

        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self

        favoritesTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "cell")

        guard let user = Auth.auth().currentUser else { return }

        appService.getUser(mail: user.email!) { (userModel) in
            guard let user = userModel else { return }

            self.setViewForNewUser(user: user)

            self.routes = user.favourites
            self.favoritesTableView.reloadData()
        }
    }

    convenience init(appService: AppService, appRouter: AppRouter) {
        self.init()

        self.appService = appService
        self.appRouter = appRouter
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

        guard let user = Auth.auth().currentUser else { return }

        appService.getUser(mail: user.email!) { (userModel) in
            guard let user = userModel else { return }

            self.setViewForNewUser(user: user)

            self.routes = user.favourites
            self.favoritesTableView.reloadData()
        }
    }

    @objc
    func showDialog() {
        multiOptionalView.isHidden = false
    }

    @objc
    func navigateToEditProfile() {
        guard let user = Auth.auth().currentUser,
            let userMail = user.email
        else {
            return
        }

        appService.getUser(mail: userMail) { (userModel) in
            guard let userModel = userModel else { return }

            self.appRouter.navigateToEditVC(userModel: userModel)
            self.multiOptionalView.isHidden = true
        }
    }

    @objc
    func navigateToAddLocation() {
        appRouter.navigateToCreateLocationVC()
        self.multiOptionalView.isHidden = true
    }

    @objc
    func navigateToAddRoute() {
        appRouter.navigateToCreateRoute()
        self.multiOptionalView.isHidden = true
    }

    func setViewForNewUser(user: UserModel) {
        let username = user.username
        let userInfoText = user.name + " " + user.surname
        let randomNumber = Int.random(in: 0..<6)
        let userIcon = UIImage(named: "avatar\(randomNumber)")

        usernameLabel.text = username
        userInfo.text = userInfoText
        profileImage.image = userIcon
    }

}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoritesTableViewCell
        cell.setFavoriteCell(routeModel: routes[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let route = routes[indexPath.row]
        let vc = RouteDetailsViewController(routeInfo: route, previousViewController: self)
        vc.routeTransitionDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let route = self.routes[indexPath.row]
            self.routes.remove(at: indexPath.row)
            tableView.reloadData()

            guard let user = Auth.auth().currentUser else { return }
            appService.removeRoutefromFavorites(userMail: user.email!, routeId: route.id)
        }
    }
}

extension ProfileViewController: RouteTransitionProtocol {
    func sendRouteToMap(route: RouteModel) {
        let vc = self.tabBarController?.viewControllers?[0] as! MapViewController

        vc.locations = route.locations
        vc.drawPins()
        vc.routeSelected = true
    }
}
