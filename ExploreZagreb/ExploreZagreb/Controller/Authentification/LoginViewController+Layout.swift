import UIKit

extension LoginViewController {
    func buildViews() {
        createViews()
        styleViews()
        addConstrains()
    }

    func createViews() {
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "Logo")
        view.addSubview(logoImageView)

        contentView = UIView()
        view.addSubview(contentView)

        stackView = UIStackView()
        contentView.addSubview(stackView)

        mailContainer = InputView()
        stackView.addArrangedSubview(mailContainer)

        passwordContainer = InputView()
        passwordContainer.inputTextField.isSecureTextEntry = true
        stackView.addArrangedSubview(passwordContainer)

        registerLabel = UILabel()
        contentView.addSubview(registerLabel)

        resetPasswordLabel = UILabel()
        contentView.addSubview(resetPasswordLabel)
        resetPasswordLabel.isHidden = true

        loginButton = UIButton()
        contentView.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(LoginViewController.loginAction), for: .touchUpInside)

        resetPasswordTapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.navigateToResetPassword))
        resetPasswordLabel.isUserInteractionEnabled = true
        resetPasswordLabel.addGestureRecognizer(resetPasswordTapGesture)

        registerTapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.navigateToRegistration))
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(registerTapGesture)

        dialogView = DialogView()
        dialogView.isHidden = true
        view.addSubview(dialogView)

        dialogView.okButton.addTarget(self, action: #selector(LoginViewController.dissmisView), for: .touchUpInside)
    }

    func styleViews() {
        view.backgroundColor = .white

        contentView.backgroundColor = .seepSkyBlue()
        contentView.layer.cornerRadius = 10

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .clear

        mailContainer.setInputView(title: "Mail:", placeholder: "Mail")
        passwordContainer.setInputView(title: "Password:", placeholder: "Password")

        registerLabel.textColor = .blue
        registerLabel.text = "Not yet registered? Register now!"
        registerLabel.textAlignment = .center

        resetPasswordLabel.textColor = .blue
        resetPasswordLabel.text = "Reset password"
        resetPasswordLabel.textAlignment = .center

        loginButton.backgroundColor = .lightBlue()
        loginButton.layer.cornerRadius = 10
        loginButton.setTitle("Login", for: .normal)

    }

    func addConstrains() {
        logoImageView.autoAlignAxis(toSuperviewAxis: .vertical)

        contentView.autoPinEdge(.top, to: .bottom, of: logoImageView, withOffset: 25)
        contentView.autoAlignAxis(toSuperviewAxis: .horizontal)
        contentView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        contentView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        stackView.autoPinEdge(toSuperviewEdge: .leading)
        stackView.autoPinEdge(toSuperviewEdge: .trailing)
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: 25)


        registerLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        registerLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        registerLabel.autoPinEdge(.top, to: .bottom, of: stackView, withOffset: 25)

        resetPasswordLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        resetPasswordLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        resetPasswordLabel.autoPinEdge(.top, to: .bottom, of: registerLabel, withOffset: 15)

        loginButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        loginButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        loginButton.autoPinEdge(.top, to: .bottom, of: resetPasswordLabel, withOffset: 25)
        loginButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 25)
        loginButton.autoSetDimension(.height, toSize: 50)

    }
}
