import Foundation

class CategoryModel{
    
    var id: Int
    var name: String
    var routes: [RouteModel]
    
    init(id : Int, name: String, routes: [RouteModel]) {
        self.id = id
        self.name = name
        self.routes = routes
    }

    init(fromJson json: [String : Any]) {
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        self.routes = []

        let routes = json["routes"] as! [[String : Any]]

        for route in routes {
            self.routes.append(RouteModel(fromJson: route))
        }
    }
}
