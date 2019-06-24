import Foundation

class UserModel {
    
    var id : Int
    var username : String
    var name: String
    var surname: String
    var userIcon: String
    var mail : String
    var favourites : [RouteModel]
    
    init(id: Int, username: String, name: String, surname: String, userIcon: String,
         mail: String, favourites: [RouteModel]) {

        self.id = id
        self.username = username
        self.name = name
        self.surname = surname
        self.userIcon = userIcon
        self.mail = mail
        self.favourites = favourites

    }

    init (fromJson json: [String : Any]) {
        self.id = json["id"] as! Int
        self.username = json["username"] as! String
        self.name = json["name"] as! String
        self.surname = json["surname"] as! String
        self.mail = json["mail"] as! String
        self.userIcon = json["userIcon"] as! String
        self.favourites = []

        let jsonFavorites = json["favorites"] as! [[String : Any]]

        for favorite in jsonFavorites {
            self.favourites.append(RouteModel(fromJson: favorite))
        }
    }

    func toPostJson() -> [String : Any] {
        var json = [String : Any]()

        json["username"] = self.username
        json["name"] = self.name
        json["surname"] = self.surname
        json["mail"] = self.mail
        json["userIcon"] = self.userIcon
        json["favorites"] = []

        return json
    }

    func toPutJson() -> [String : Any] {
        var json = [String : Any]()

        json["id"] = self.id
        json["username"] = self.username
        json["name"] = self.name
        json["surname"] = self.surname
        json["mail"] = self.mail
        json["userIcon"] = self.userIcon
        json["favorites"] = []

        return json
    }

}
