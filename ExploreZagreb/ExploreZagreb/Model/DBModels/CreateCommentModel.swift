import Foundation

class CreateCommentModel {
    var comment: String
    var userMail: String
    var routeId: Int

    init(comment: String, userMail: String, routeId: Int) {
        self.comment = comment
        self.userMail = userMail
        self.routeId = routeId
    }

    func toJson() -> [String : Any] {
        var json = [String : Any]()

        json["comment"] = self.comment
        json["userMail"] = self.userMail
        json["routeId"] = self.routeId

        return json
    }
}
