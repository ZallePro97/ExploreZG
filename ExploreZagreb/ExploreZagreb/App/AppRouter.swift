import Foundation
import UIKit

class AppRouter {

    private let window: UIWindow
    private let appService: AppService!
    private var navigationController: UINavigationController!

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.appService = AppService()
    }

    func setInitialState() {
        let loginVC = LoginViewController(appService: appService, appRouter: self)

        navigationController.navigationBar.isHidden = true
        navigationController.viewControllers = [loginVC]

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func setTabBarVCasRoot() {
        let tabBarController = UITabBarController()

        let mapViewController = MapViewController()
        mapViewController.tabBarItem = UITabBarItem.init(title: "Map", image: UIImage(named: "map"), tag: 0)

        let routeListViewController = RoutesListViewController()
        routeListViewController.tabBarItem = UITabBarItem.init(title: "Routes", image: UIImage(named: "list"), tag: 1)

        let profileViewController = ProfileViewController(appService: appService, appRouter: self)
        profileViewController.tabBarItem = UITabBarItem.init(title: "Profile", image: UIImage(named: "icProfile"), tag: 2)

        tabBarController.viewControllers = [mapViewController, routeListViewController, profileViewController]

        navigationController.navigationBar.isHidden = true
        navigationController.viewControllers = [tabBarController]
    }

    func navigateToEditVC(userModel: UserModel) {
        let registrationVC = RegistrationViewController(appService: appService, appRouter: self, entryType: .edit, userModel: userModel)
        let tabBarVC = navigationController.visibleViewController as! UITabBarController
        let profileVC = tabBarVC.viewControllers?[2] as! ProfileViewController
        registrationVC.userProtocol = profileVC
        navigationController.pushViewController(registrationVC, animated: true)
    }

    func navigateToRegistrationVC() {
        let registrationVC = RegistrationViewController(appService: appService, appRouter: self, entryType: .register, userModel: nil)

        navigationController.pushViewController(registrationVC, animated: true)
    }

    func navigateToCreateLocationVC() {
        let createLocationVC = CreateLocationViewController(appService: appService, appRouter: self)

        navigationController.pushViewController(createLocationVC, animated: true)
    }

    func navigateToCreateRoute() {
        let createRouteVC = CreateRouteViewController(appService: appService, appRouter: self)

        navigationController.pushViewController(createRouteVC, animated: true)
    }
}
