import Foundation
import UIKit

class CommentCell: UITableViewCell {
    
    var commentLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }
    
    func buildViews() {
        
        commentLabel = UILabel()
        contentView.addSubview(commentLabel)
        
        commentLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
        commentLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 25)
        commentLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        commentLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        commentLabel.textAlignment = .left
    }
    
}
