import Foundation

class LocationModel {
    
    var id : Int
    var name : String
    var picturePath : String
    var latitude : Double
    var longitude: Double
    var address : String
    var description : String
    var wikiLink : String
    
    init(id: Int,name: String, picturePath : String, latitude : Double, longitude : Double, address: String, description: String, wikiLink: String) {
        
        self.id = id
        self.name = name
        self.picturePath = picturePath
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.description = description
        self.wikiLink = wikiLink
    }

    init(fromJson json: [String : Any]) {
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        self.picturePath = json["picturePath"] as! String
        self.latitude = json["latitude"] as! Double
        self.longitude = json["longitude"] as! Double
        self.address = json["address"] as! String
        self.description = json["description"] as! String
        self.wikiLink = json["wikiLink"] as! String
    }
    
    init(location: LocationModel) {
        self.id = location.id
        self.name = location.name
        self.picturePath = location.picturePath
        self.latitude = location.latitude
        self.longitude = location.longitude
        self.address = location.address
        self.description = location.description
        self.wikiLink = location.wikiLink
    }

    func toPostJson() -> [String : Any] {
        var json = [String : Any]()

        json["name"] = self.name
        json["picturePath"] = self.picturePath
        json["latitude"] = self.latitude
        json["longitude"] = self.longitude
        json["address"] = self.address
        json["description"] = self.description
        json["wikiLink"] = self.wikiLink

        return json
    }
        
}

extension LocationModel: Equatable {
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.picturePath == rhs.picturePath &&
            lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude &&
            lhs.name == rhs.name &&
            lhs.address == rhs.address &&
            lhs.description == rhs.description
    }
}
