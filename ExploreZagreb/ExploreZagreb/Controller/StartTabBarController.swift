//
//  ViewController.swift
//  ExploreZagreb
//
//  Created by Borna Relic on 5/22/19.
//  Copyright © 2019 Zelena Mrkva. All rights reserved.
//

import UIKit

class StartTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapVC = MapViewController()
        mapVC.tabBarItem = UITabBarItem.init(title: "Map", image: UIImage(named: "map"), tag: 0)
        
        let routeListVC = RoutesListViewController()
        let navigationController : UINavigationController
        navigationController = UINavigationController(rootViewController: routeListVC)
        
        navigationController.tabBarItem = UITabBarItem.init(title: "Routes", image: UIImage(named: "list"), tag: 1)
    
        
        let tabBarList = [mapVC, navigationController]
        viewControllers = tabBarList
    }


}

