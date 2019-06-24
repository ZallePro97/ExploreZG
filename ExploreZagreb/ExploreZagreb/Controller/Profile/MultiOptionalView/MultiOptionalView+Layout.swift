import UIKit

extension MultiOptionalView {
    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        backView = UIView()
        addSubview(backView)

        tapGesture = UITapGestureRecognizer(target: self, action: #selector(MultiOptionalView.hideDialog))
        backView.addGestureRecognizer(tapGesture)

        containerView = UIView()
        backView.addSubview(containerView)

        stackView = UIStackView()
        containerView.addSubview(stackView)

        editProfileButton = UIButton()
        stackView.addArrangedSubview(editProfileButton)

        addLocationButton = UIButton()
        stackView.addArrangedSubview(addLocationButton)

        addRouteButton = UIButton()
        stackView.addArrangedSubview(addRouteButton)
    }

    func styleViews() {
        backView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)

        containerView.backgroundColor = .gray
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .gray
        stackView.spacing = 1

        editProfileButton.setTitle("Edit profile", for: .normal)
        editProfileButton.setTitleColor(.black, for: .normal)
        editProfileButton.backgroundColor = .white
        addLocationButton.setTitle("Add new location", for: .normal)
        addLocationButton.setTitleColor(.black, for: .normal)
        addLocationButton.backgroundColor = .white
        addRouteButton.setTitle("Add new Route", for: .normal)
        addRouteButton.setTitleColor(.black, for: .normal)
        addRouteButton.backgroundColor = .white
    }

    func addConstraints() {
        guard superview != nil else { return }

        autoPinEdgesToSuperviewEdges()
        backView.autoPinEdgesToSuperviewEdges()
        stackView.autoPinEdgesToSuperviewEdges()

        containerView.autoAlignAxis(toSuperviewAxis: .horizontal)
        containerView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        containerView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        editProfileButton.autoSetDimension(.height, toSize: 70)
        addLocationButton.autoSetDimension(.height, toSize: 70)
        addRouteButton.autoSetDimension(.height, toSize: 70)
    }
}
