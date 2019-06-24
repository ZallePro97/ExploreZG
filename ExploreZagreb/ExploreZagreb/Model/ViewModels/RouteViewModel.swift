import Foundation

class RouteViewModel{
    
    var category : String
    var routes : [Route]
    
    init(category : String, routes: [Route]) {
        self.category = category
        self.routes = routes
    }
}
