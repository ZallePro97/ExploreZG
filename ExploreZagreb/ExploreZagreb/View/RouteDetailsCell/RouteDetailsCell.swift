import UIKit

class RouteDetailsCell: UITableViewCell {
    
    var locationNameLabel: UILabel!
    var pinImage : UIImage!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }
    
    func buildViews() {
        
        pinImage = UIImage(named: "location_pin")
        let imageView = UIImageView(image: pinImage)
        contentView.addSubview(imageView)
        
        imageView.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
        imageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 30)
        
        locationNameLabel = UILabel()
        contentView.addSubview(locationNameLabel)
        
        locationNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
        locationNameLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 25)
        locationNameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        locationNameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        locationNameLabel.textAlignment = .center
        
        locationNameLabel.font = locationNameLabel.font.withSize(15)
    }
    
}
