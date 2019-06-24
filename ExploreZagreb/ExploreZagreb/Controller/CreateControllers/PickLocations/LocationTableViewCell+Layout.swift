import UIKit

extension LocationTableViewCell {
    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        locationImageView = UIImageView()
        contentView.addSubview(locationImageView)

        locationNameLabel = UILabel()
        contentView.addSubview(locationNameLabel)

        checkMarkImageView = UIImageView()
        checkMarkImageView.isHidden = true
        checkMarkImageView.image = UIImage(named: "checkmark")
        contentView.addSubview(checkMarkImageView)
    }

    func styleViews() {
        contentView.backgroundColor = .white

        locationImageView.layer.cornerRadius = 20
        locationImageView.clipsToBounds = true
        locationImageView.contentMode = .scaleAspectFit

        checkMarkImageView.layer.cornerRadius = 20
        checkMarkImageView.clipsToBounds = true
        checkMarkImageView.contentMode = .scaleAspectFit

        locationNameLabel.textAlignment = .center
        locationNameLabel.numberOfLines = 2
    }

    func addConstraints() {
        guard superview != nil else { return }

        locationImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        locationImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        locationImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15)
        locationImageView.autoPinEdge(.trailing, to: .leading, of: locationNameLabel)
        locationImageView.autoSetDimensions(to: CGSize(width: 40, height: 40))

        locationNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        locationNameLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15)
        locationImageView.autoPinEdge(.trailing, to: .leading, of: checkMarkImageView)


        checkMarkImageView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        checkMarkImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 25)
        checkMarkImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 25)
        checkMarkImageView.autoMatch(.width, to: .height, of: checkMarkImageView)

    }
}
