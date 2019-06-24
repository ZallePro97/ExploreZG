//
//  RouteListViewController.swift
//  ExploreZagreb
//
//  Created by Five on 04/06/2019.
//  Copyright © 2019 Zelena Mrkva. All rights reserved.
//

import UIKit
import PureLayout
import MapKit

struct routeDetails{
    var coordinates = [Int]()
    var title = String()
    var popularity = String()
    var likes = String()
    var dislikes = String()
    var locations = [String]()
}


class RouteDetailsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var map_view: MKMapView!
    
    @IBOutlet weak var route_title: UILabel!
    
    @IBOutlet weak var popularity_label: UILabel!
    @IBOutlet weak var likes_btn: UIButton!
    
    @IBOutlet weak var dislikes_btn: UIButton!
    
    @IBOutlet weak var locations_list: UITableView!
    
    @IBOutlet weak var start_btn: UIButton!
    
    
    let url = "https://iosquiz.herokuapp.com/api/quizzes"
    
    let routeService = RouteService()
    
    //TODO prebaciti u init
    var route_details = routeDetails(coordinates: [1,2,3],title: "My favourite route",popularity: "100",likes: "63",dislikes: "2",locations: ["lokacija1","lokacija2","lokacija3","lokacija4"])
    
    init(id : String) {
        //self.route_details = 
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc
    func startButtonClicked(_ sender: AnyObject){
        
        //TODO otvoriti mapu i zapoceti rutu
    }
    
    override func viewDidLoad() {
        
        //fetchQuiz(quizService: quizService, url: url, viewController: self)
        
        locations_list.dataSource = self
        locations_list.delegate = self
        locations_list.backgroundColor = UIColor.white
        
        locations_list.register(RouteDetailsCell.self, forCellReuseIdentifier: "cell")
        
        setView()
    }
    
    func setView(){
        route_title.text = route_details.title
        popularity_label.text = "popularity: " + route_details.popularity
        likes_btn.setTitle(" like " + route_details.likes, for: .normal)
        dislikes_btn.setTitle(" dislike " + route_details.dislikes, for: .normal)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RouteDetailsCell
        
        let locationName = route_details.locations[indexPath.row]
            
        cell.locationNameLabel.text = locationName
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return route_details.locations.count
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //TODO prijeci na mapu
    }
    
    
    
}

//func fetchQuiz(quizService:QuizService, url : String, viewController: TableViewController){
//    quizService.fetchQuiz(urlString: url){ (quiz) in
//        DispatchQueue.main.async {
//            if quiz == nil{
//                
//                viewController.error_label.isHidden = false
//                viewController.error_label.text = "Nažalost ne možemo dohvatiti kviz, pokušajte kasnije."
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                    viewController.error_label.isHidden = true
//                }
//            }
//            else{
//                viewController.categories = quiz?.listOfCategories ?? []
//                for category in quiz?.listOfCategories ?? []{
//                    if viewController.categoriesDict.keys.contains(category.category){
//                        viewController.categoriesDict[category.category]?.append(category)
//                    }
//                    else{
//                        viewController.categoriesDict[category.category] = [category]
//                    }
//                }
//                viewController.tableView.reloadData()
//            }
//            
//        }
//    }
//}






