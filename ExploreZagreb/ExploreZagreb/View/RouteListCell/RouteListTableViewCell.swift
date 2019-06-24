import UIKit

class RouteListTableViewCell: UITableViewCell {
    
    var routeNameLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }
    
    func buildViews() {
        routeNameLabel = UILabel()
        contentView.addSubview(routeNameLabel)
        
        routeNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
        routeNameLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 25)
        routeNameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        routeNameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        routeNameLabel.textAlignment = .center

        routeNameLabel.font = routeNameLabel.font.withSize(20)
        
    }

}
