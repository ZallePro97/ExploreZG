import UIKit
import Kingfisher

class FavoritesTableViewCell: UITableViewCell {

    var routeNameLabel: UILabel!
    var routeModel: RouteModel?

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
        routeNameLabel.text = nil
    }

    func setFavoriteCell(routeModel: RouteModel) {
        self.routeModel = routeModel

        routeNameLabel.text = routeModel.name
    }

}
