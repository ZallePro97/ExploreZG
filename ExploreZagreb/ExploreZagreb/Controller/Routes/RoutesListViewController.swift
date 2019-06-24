import UIKit
import PureLayout

struct cellData{
    var opened = Bool()
    var title = String()
    var sectionData = [RouteModel]()
}

class RoutesListViewController: UITableViewController, RouteTransitionProtocol {

    let url = "https://iosquiz.herokuapp.com/api/quizzes"
    
    let appService = AppService()

    var routes = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem = UITabBarItem.init(title: "Routes", image: UIImage(named: "list"), tag: 1)
        
        view.backgroundColor = .white

        appService.getAllCategories { (categories) in
            guard let categories = categories else { return }
            
            for cat in categories{
                let category = cellData(opened: false,
                                        title: cat.name,
                                        sectionData: cat.routes)
                
                self.routes.append(category)
            }
            self.tableView.reloadData()
        }

        tableView.register(RouteListTableViewCell.self, forCellReuseIdentifier: "cell")
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action:
            #selector(RoutesListViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl?.tintColor = .red

        tableView.addSubview(refreshControl!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = true
    }

    @objc
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        appService.getAllCategories { (categories) in
            guard let categories = categories else { return }

            var models = [cellData]()
            for cat in categories{
                let category = cellData(opened: false,
                                        title: cat.name,
                                        sectionData: cat.routes)

                models.append(category)
            }
            self.routes = models
            self.tableView.reloadData()
        }

        refreshControl.endRefreshing()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return routes.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if routes[section].opened{
            return routes[section].sectionData.count + 1
        }
        else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RouteListTableViewCell
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 8
        

        
        if indexPath.row == 0{
            let categoryName = routes[indexPath.section].title
            
            cell.routeNameLabel.text = categoryName
            cell.routeNameLabel.textColor = .white
            cell.backgroundColor = .blue
            cell.layer.cornerRadius = 20.0
            cell.clipsToBounds = true
        }
        else{
            
            let routeName = routes[indexPath.section].sectionData[indexPath.row - 1].name
            
            cell.routeNameLabel.text = routeName
            cell.routeNameLabel.textColor = .black
            cell.backgroundColor = .white
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if routes[indexPath.section].opened{
                routes[indexPath.section].opened = false
            }
            else{
                routes[indexPath.section].opened = true
            }
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none) //animacija
        }
        else{
            tableView.deselectRow(at: indexPath, animated: true)
            
        
            let routeData = routes[indexPath.section].sectionData[indexPath.row - 1]
                
            let routeDetailsVC = RouteDetailsViewController(routeInfo: routeData, previousViewController: self)
            routeDetailsVC.routeTransitionDelegate = self

            self.navigationController?.pushViewController(routeDetailsVC, animated: true)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 80
        }
        else{
            return 80
        }
    }

    func sendRouteToMap(route: RouteModel) {
        guard let mapViewController = self.tabBarController?.viewControllers? [0] as? MapViewController else { return }

        mapViewController.locations = route.locations
        mapViewController.drawPins()
        mapViewController.routeSelected = true
    }
}
