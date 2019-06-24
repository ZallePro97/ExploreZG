import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    private var appService: AppService!
    private var appRouter: AppRouter!

    var dialogView: DialogView!

    var contentView: UIView!
    var stackView: UIStackView!

    var mailContainer: InputView!
    var passwordContainer: InputView!

    var loginButton: UIButton!
    var registerLabel: UILabel!
    var resetPasswordLabel: UILabel!

    var logoImageView: UIImageView!

    var registerTapGesture: UITapGestureRecognizer!
    var resetPasswordTapGesture: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        buildViews()
    }

    convenience init (appService: AppService, appRouter: AppRouter) {
        self.init()

        self.appService = appService
        self.appRouter = appRouter
    }

    @objc
    func navigateToRegistration() {
        appRouter.navigateToRegistrationVC()
    }

    @objc
    func navigateToResetPassword() {

    }

    @objc
    func loginAction() {
        guard let mail = mailContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces),
            let password = passwordContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces)
        else {
            return
        }

        //DODANO za prolaz autentifikacije
        self.appRouter.setTabBarVCasRoot()
        
        Auth.auth().signIn(withEmail: mail, password: password) { (authResult, error) in
            guard let user = authResult?.user else {
                self.showDialog(withMessage: "Error happned!\nPlease try again.")
                return
            }
            
            if user.isEmailVerified {
                self.appRouter.setTabBarVCasRoot()
            } else {
                self.showDialog(withMessage: "Please verify email to proceed.")
                do {
                    try Auth.auth().signOut()
                } catch {
                    self.showDialog(withMessage: "Error happned!\nPlease try again.")
                }
            }
        }
    }

    func showDialog(withMessage message: String?) {
        dialogView.messageLabel.text = message
        dialogView.isHidden = false
    }

    @objc
    func dissmisView() {
        dialogView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
