import Foundation

class Route {
    
    var title: String?
    var locations: [Location] = []
    
    init(title: String) {
        self.title = title
    }
    
    init(title: String, locations: [Location]) {
        self.title = title
        self.locations = locations
    }
    
}
