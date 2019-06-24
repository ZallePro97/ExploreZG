import UIKit

extension DialogView {
    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        backView = UIView()
        addSubview(backView)

        containerView = UIView()
        backView.addSubview(containerView)

        messageLabel = UILabel()
        containerView.addSubview(messageLabel)

        okButton = UIButton()
        containerView.addSubview(okButton)
    }

    func styleViews() {
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        okButton.setTitle("Dissmis", for: .normal)
        okButton.setTitleColor(.black, for: .normal)

        backView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
    }

    func addConstraints() {
        guard superview != nil else { return }

        autoPinEdgesToSuperviewEdges()
        backView.autoPinEdgesToSuperviewEdges()

        containerView.autoAlignAxis(toSuperviewAxis: .horizontal)
        containerView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        containerView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        messageLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        messageLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        messageLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 25)

        okButton.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        okButton.autoPinEdge(.top, to: .bottom, of: messageLabel, withOffset: 25)
        okButton.autoSetDimension(.height, toSize: 50)

    }
}
