//
//  TableViewController.swift
//  QuizTime
//
//  Created by Five on 06/05/2019.
//  Copyright © 2019 Five. All rights reserved.
//

import UIKit
import PureLayout
// import Kingfisher

class RouteListViewController1 : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let url = "https://iosquiz.herokuapp.com/api/quizzes"
    
    let routeService = RouteService()
    
    var routeNames : [String] = []
    
    var tableView = UITableView()
    
    @objc
    func filterButtonClicked(_ sender: AnyObject){
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = UITabBarItem.init(title: "Routes", image: UIImage(named: "list"), tag: 1)
        
        view.backgroundColor = .white
        
        //fetchRoutes(routeService: routeService, url: url, viewController: self)
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        
        tableView.register(RouteListTableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        //tableView.autoPinEdge(toSuperviewEdge: .leading)
        //tableView.autoPinEdge(toSuperviewEdge: .trailing)
        tableView.autoPinEdgesToSuperviewMargins()

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let routeName = routeNames[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RouteListTableViewCell
        
        cell.routeNameLabel.text = routeName
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeNames.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        let key = Array(categoriesDict.keys)[indexPath.section]
        //
                let cell = tableView.cellForRow(at: indexPath)
                cell?.isSelected = false
        //
        //        if let category = categoriesDict[key]?[indexPath.row]{
        //
        //            let quizViewController = QuizViewController(quiz_data: category)
        //
        //            self.navigationController?.pushViewController(quizViewController, animated: true)
        //
        //        }
        
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
                //viewController.routeNames = routes ?? []
                viewController.tableView.reloadData()
            }
            
        }
    }
}






