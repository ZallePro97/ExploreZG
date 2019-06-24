import UIKit

extension InputView {
    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        labelContainer = UIView()
        stackView.addArrangedSubview(labelContainer)

        textFieldContainer = UIView()
        stackView.addArrangedSubview(textFieldContainer)

        titleLabel = UILabel()
        titleLabel.isHidden = true
        labelContainer.addSubview(titleLabel)

        inputTextField = UITextField()
        textFieldContainer.addSubview(inputTextField)

        separatorContainer = UIView()
        stackView.addArrangedSubview(separatorContainer)

        separatorView = UIView()
        separatorContainer.addSubview(separatorView)

        errorMessageContainer = UIView()
        errorMessageContainer.isHidden = true
        stackView.addArrangedSubview(errorMessageContainer)

        errorMessage = UILabel()
        errorMessageContainer.addSubview(errorMessage)
    }

    func styleViews() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .clear

        labelContainer.backgroundColor = .clear
        textFieldContainer.backgroundColor = .clear
        titleLabel.backgroundColor = .clear
        inputTextField.backgroundColor = .clear
        errorMessage.backgroundColor = .clear
        errorMessageContainer.backgroundColor = .clear

        separatorView.backgroundColor = .gray

        errorMessage.textColor = .red
    }

    func addConstraints() {
        guard superview != nil else { return }
        
        stackView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        stackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)

        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        titleLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)

        inputTextField.autoPinEdge(toSuperviewEdge: .top)
        inputTextField.autoPinEdge(toSuperviewEdge: .bottom)
        inputTextField.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        inputTextField.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        inputTextField.autoSetDimension(.height, toSize: 44)

        separatorView.autoPinEdge(toSuperviewEdge: .top)
        separatorView.autoPinEdge(toSuperviewEdge: .bottom)
        separatorView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        separatorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        separatorView.autoSetDimension(.height, toSize: 1)

        errorMessage.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        errorMessage.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        errorMessage.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        errorMessage.autoPinEdge(toSuperviewEdge: .bottom)
    }
}
