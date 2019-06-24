class CreateRouteModel {

    var name: String
    var categoryName: String
    var numberOfLikes: Int = 0
    var numberOfDislikes: Int = 0
    var popularity: Int = 0
    var locationIds: [Int]

    init(name: String, categoryName: String, locationIds: [Int]) {
        self.name = name
        self.categoryName = categoryName
        self.locationIds = locationIds
    }

    func toJson() -> [String : Any] {
        var json = [String : Any]()

        json["name"] = self.name
        json["categoryName"] = self.categoryName
        json["numberOfLikes"] = self.numberOfLikes
        json["numberOfDislikes"] = self.numberOfDislikes
        json["popularity"] = self.popularity
        json["locationIds"] = self.locationIds

        return json
    }
}
