import UIKit

extension RegistrationViewController {
    func buildViews() {
        createViews()
        styleViews()
        addConstrains()
    }

    func createViews() {
        infoLabel = UILabel()
        view.addSubview(infoLabel)

        scrollView = UIScrollView()
        view.addSubview(scrollView)

        cardView = UIView()
        scrollView.addSubview(cardView)

        contentView = UIView()
        cardView.addSubview(contentView)

        stackView = UIStackView()
        contentView.addSubview(stackView)

        usernameContainer = InputView()
        stackView.addArrangedSubview(usernameContainer)

        nameContainer = InputView()
        stackView.addArrangedSubview(nameContainer)

        surnameContainer = InputView()
        stackView.addArrangedSubview(surnameContainer)

        mailContainer = InputView()
        stackView.addArrangedSubview(mailContainer)

        passwordContainer = InputView()
        stackView.addArrangedSubview(passwordContainer)

        repeatPasswordContainer = InputView()
        stackView.addArrangedSubview(repeatPasswordContainer)

        registerButton = UIButton()
        registerButton.addTarget(self, action: #selector(RegistrationViewController.handleButtonTap), for: .touchUpInside)
        view.addSubview(registerButton)

        dialogView = DialogView()
        dialogView.isHidden = true
        view.addSubview(dialogView)

        dialogView.okButton.addTarget(self, action: #selector(RegistrationViewController.dissmisView), for: .touchUpInside)
    }

    func styleViews() {
        view.backgroundColor = .white

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
        stackView.spacing = 10

        usernameContainer.setInputView(title: "Username:", placeholder: "Username")
        nameContainer.setInputView(title: "Name:", placeholder: "Name")
        surnameContainer.setInputView(title: "Surname:", placeholder: "Surname")
        mailContainer.setInputView(title: "Mail:", placeholder: "Mail")

        passwordContainer.setInputView(title: "Password:", placeholder: "Password")
        passwordContainer.inputTextField.isSecureTextEntry = true

        repeatPasswordContainer.setInputView(title: "Repeat password:", placeholder: "Repeat password")
        repeatPasswordContainer.inputTextField.isSecureTextEntry = true

        infoLabel.text = "Profile informations:"
        infoLabel.font = infoLabel.font.withSize(30)


        registerButton.backgroundColor = .seepSkyBlue()
        registerButton.setTitle("Register", for: .normal)

        view.backgroundColor = UIColor.lightBlue()

        contentView.backgroundColor = .seepSkyBlue()
        contentView.layer.cornerRadius = 25
    }

    func addConstrains() {
        infoLabel.autoPinEdge(toSuperviewMargin: .top, withInset: 25)
        infoLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        infoLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        scrollView.autoPinEdge(.top, to: .bottom, of: infoLabel, withOffset: 25)
        scrollView.autoPinEdge(toSuperviewEdge: .leading)
        scrollView.autoPinEdge(toSuperviewEdge: .trailing)

        cardView.autoPinEdgesToSuperviewEdges()
        cardView.autoMatch(.width, to: .width, of: view)

        contentView.autoPinEdge(toSuperviewMargin: .top, withInset: 10)
        contentView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        contentView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        contentView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)

        stackView.autoPinEdgesToSuperviewEdges()

        registerButton.autoPinEdge(toSuperviewEdge: .leading)
        registerButton.autoPinEdge(toSuperviewEdge: .trailing)
        registerButton.autoPinEdge(toSuperviewMargin: .bottom)
        registerButton.autoPinEdge(.top, to: .bottom, of: scrollView)
        registerButton.autoSetDimension(.height, toSize: 55)
    }
}
