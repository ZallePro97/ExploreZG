import UIKit

extension FavoritesTableViewCell {
    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        routeNameLabel = UILabel()
        contentView.addSubview(routeNameLabel)
    }

    func styleViews() {
        contentView.backgroundColor = .white

        routeNameLabel.textAlignment = .center
        routeNameLabel.numberOfLines = 2
    }

    func addConstraints() {
        guard superview != nil else { return }

        routeNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        routeNameLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15)
        routeNameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
        routeNameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 15)
    }
}
