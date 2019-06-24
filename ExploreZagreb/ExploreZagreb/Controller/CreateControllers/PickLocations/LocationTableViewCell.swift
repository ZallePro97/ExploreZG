import UIKit
import Kingfisher

class LocationTableViewCell: UITableViewCell {

    var locationImageView: UIImageView!
    var locationNameLabel: UILabel!
    var locationModel: LocationModel?
    var checkMarkImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        locationImageView.image = nil
        locationNameLabel.text = nil
        contentView.backgroundColor = .white
    }

    func setLocationCell(locationModel: LocationModel) {
        self.locationModel = locationModel

        locationNameLabel.text = locationModel.name

        if let url = URL(string: locationModel.picturePath) {
            locationImageView.kf.setImage(with: url)
        } else {
            locationImageView.image = UIImage(named: "location_pin")
        }
    }

}
