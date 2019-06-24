import UIKit
import FirebaseAuth

enum EntryType {
    case edit
    case register
}

protocol EditUserProtocol {
    func setViewForNewUser(user: UserModel)
}

class RegistrationViewController: UIViewController {

    private var appService: AppService!
    private var appRouter: AppRouter!
    private var entryType: EntryType!
    private var userModel: UserModel?

    var dialogView: DialogView!
    var error: Bool = false

    var scrollView: UIScrollView!
    var cardView: UIView!
    var contentView: UIView!
    var stackView: UIStackView!

    var infoLabel: UILabel!

    var usernameContainer: InputView!
    var nameContainer: InputView!
    var surnameContainer: InputView!
    var mailContainer: InputView!
    var passwordContainer: InputView!
    var repeatPasswordContainer: InputView!

    var registerButton: UIButton!

    var userProtocol: EditUserProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()

        setUI()
    }

    convenience init (appService: AppService, appRouter: AppRouter, entryType: EntryType, userModel: UserModel?) {
        self.init()

        self.appService = appService
        self.appRouter = appRouter
        self.entryType = entryType
        self.userModel = userModel
    }

    func setUI() {
        if entryType == .edit {
            guard let user = userModel else { return }
            passwordContainer.isHidden = true
            repeatPasswordContainer.isHidden = true
            mailContainer.isHidden = true
            registerButton.setTitle("Save changes", for: .normal)

            nameContainer.inputTextField.text = user.name
            surnameContainer.inputTextField.text = user.surname
            usernameContainer.inputTextField.text = user.username
            nameContainer.titleLabel.isHidden = false
            surnameContainer.titleLabel.isHidden = false
            usernameContainer.titleLabel.isHidden = false
        }
    }

    func handleRegistrationButton() {
        error = false

        guard let mail = mailContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces).lowercased(),
            let password = passwordContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces),
            let repeatPassword = repeatPasswordContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces),
            let name = nameContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces),
            let surname = surnameContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces),
            let username = usernameContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces)
        else {
            error = true
            showDialog(withMessage: "All fields are required!")
            return
        }

        var anyEmpty = false

        if mail.isEmpty {
            mailContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if password.isEmpty {
            passwordContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if repeatPassword.isEmpty {
            repeatPasswordContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if name.isEmpty {
            nameContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if surname.isEmpty {
            surnameContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if username.isEmpty {
            usernameContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if anyEmpty { return }

        if password != repeatPassword {
            error = true
            showDialog(withMessage: "Password and repeat password needs to be the same.")
            passwordContainer.inputTextField.text = ""
            repeatPasswordContainer.inputTextField.text = ""
            return
        }

        Auth.auth().createUser(withEmail: mail, password: password) { (authResult, error) in
            guard let user = authResult?.user else {
                self.error = true
                self.showDialog(withMessage: "Error happned!\nPlease try again.")
                return
            }

            user.sendEmailVerification(completion: nil)

            let userModel = UserModel(id: 0, username: username, name: name, surname: surname, userIcon: "0", mail: mail, favourites: [])
            self.appService.createUser(user: userModel, completion: { (userModel) in
                if let user = userModel {
                    self.showDialog(withMessage: "Verification mail was send to your email adress.")
                }
            })
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = false
    }

    func handleEditButton() {
        error = false

        guard let name = nameContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces),
            let surname = surnameContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces),
            let username = usernameContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces)
            else {
                error = true
                showDialog(withMessage: "All fields are required!")
                return
        }

        var anyEmpty = false

        if name.isEmpty {
            nameContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if surname.isEmpty {
            surnameContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if username.isEmpty {
            usernameContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if anyEmpty { return }

        guard let userModel = userModel else {
            return
        }

        let user = UserModel(id: userModel.id, username: username, name: name, surname: surname, userIcon: userModel.userIcon, mail: userModel.mail, favourites: userModel.favourites)
        appService.updateUser(user: user) { userModel in
            guard let user = userModel else { return }

            self.userProtocol?.setViewForNewUser(user: user)
            self.navigationController?.popViewController(animated: true)
        }
    }

    @objc
    func handleButtonTap() {
        if entryType == .edit {
            handleEditButton()
        } else {
            handleRegistrationButton()
        }
    }

    func showDialog(withMessage message: String?) {
        dialogView.messageLabel.text = message
        dialogView.isHidden = false
    }

    @objc
    func dissmisView() {
        if !error {
            self.navigationController?.popViewController(animated: true)
            return
        }

        dialogView.isHidden = true
    }

}
