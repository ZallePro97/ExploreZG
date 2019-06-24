import Foundation

class RouteModel {
    
    var id : Int
    var numberOfLikes : Int
    var numberOfDislikes : Int
    var popularity : Int
    var name : String
    var locations : [LocationModel]
    var comments : [CommentModel]
    
    init(id: Int,
         numberOfLikes : Int,
         numberOfDislikes : Int,
         popularity : Int,
         name: String,
         locations : [LocationModel],
         comments: [CommentModel]
        ) {
        self.id = id
        self.numberOfLikes = numberOfLikes
        self.numberOfDislikes = numberOfDislikes
        self.popularity = popularity
        self.name = name
        self.locations = locations
        self.comments = comments
    }

    init(fromJson json: [String : Any]) {
        self.id = json["id"] as! Int
        self.numberOfLikes = json["numberOfLikes"] as! Int
        self.numberOfDislikes = json["numberOfDislikes"] as! Int
        self.popularity = json["popularity"] as! Int
        self.name = json["name"] as! String
        self.locations = []
        self.comments = []

        let jsonLocations = json["locations"] as! [[String : Any]]
        for location in jsonLocations {
            self.locations.append(LocationModel(fromJson: location))
        }
        
        let jsonComments = json["comments"] as! [[String : Any]]
        for comment in jsonComments {
            self.comments.append(CommentModel(fromJson: comment))
        }
    }
        
}

extension RouteModel: Equatable, Hashable {

    var hashValue: Int {
        return id
    }

    static func == (lhs: RouteModel, rhs: RouteModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.numberOfLikes == rhs.numberOfLikes &&
        lhs.numberOfDislikes == rhs.numberOfDislikes &&
        lhs.popularity == rhs.popularity &&
        lhs.name == rhs.name &&
        lhs.comments == rhs.comments &&
        lhs.locations == rhs.locations
    }
}
