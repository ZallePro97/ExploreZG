import Foundation

class CommentModel {
    
    var id : Int
    var comment: String
    
    init(id: Int, comment: String) {
        self.id = id
        self.comment = comment
    }
    
    init(fromJson json: [String : Any]) {
        self.id = json["id"] as! Int
        self.comment = json["comment"] as! String
    }
}

extension CommentModel: Equatable {
    static func == (lhs: CommentModel, rhs: CommentModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.comment == rhs.comment
    }
}
