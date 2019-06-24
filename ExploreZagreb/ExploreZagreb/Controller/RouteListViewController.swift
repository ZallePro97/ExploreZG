//
//  RouteListViewController.swift
//  ExploreZagreb
//
//  Created by Five on 04/06/2019.
//  Copyright © 2019 Zelena Mrkva. All rights reserved.
//

import UIKit

struct cellData{
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class RouteListViewController: UITableViewController {
    
    let url = "https://iosquiz.herokuapp.com/api/quizzes"
    
    let routeService = RouteService()
    
    var routes = [cellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem = UITabBarItem.init(title: "Routes", image: UIImage(named: "list"), tag: 1)
        
        view.backgroundColor = .white
        
        fetchRoutes(routeService: routeService, url: url, viewController: self)
        
        tableView.register(RouteListTableViewCell.self, forCellReuseIdentifier: "cell")
        
//        view.addSubview(UITableViewController.tableView(self))
        
        //tableView.autoPinEdge(toSuperviewEdge: .leading)
        //tableView.autoPinEdge(toSuperviewEdge: .trailing)
//        tableView.autoPinEdgesToSuperviewMargins()
        

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
        
        if indexPath.row == 0{
            //TODO customizirati headere
            let categoryName = routes[indexPath.section].title
            
            cell.routeNameLabel.text = categoryName
            cell.routeNameLabel.textColor = .blue
        }
        else{
            
            let routeName = routes[indexPath.section].sectionData[indexPath.row - 1]
            
            cell.routeNameLabel.text = routeName
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
            //TODO prijelaz u novi screen
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func fetchRoutes(routeService:RouteService, url : String, viewController: RouteListViewController){
        routeService.fetchRoutes(urlString: url){ (routes) in
            DispatchQueue.main.async {
                if routes == nil{
                    
                    //                viewController.error_label.isHidden = false
                    //                viewController.error_label.text = "Nažalost ne možemo dohvatiti kviz, pokušajte kasnije."
                    //                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    //                    viewController.error_label.isHidden = true
                    //                }
                }
                else{
                    for key in routes!.keys{
                        let category = cellData(opened: false,
                                                title: key,
                                                sectionData: routes?[key] ?? [])
                        
                        viewController.routes.append(category)
                    }
                    viewController.tableView.reloadData()
                }
                
            }
        }
    }
}
