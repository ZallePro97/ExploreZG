import UIKit

class InputView: UIView {

    var stackView: UIStackView!

    var labelContainer: UIView!
    var titleLabel: UILabel!
    var textFieldContainer: UIView!
    var inputTextField: UITextField!
    var separatorContainer: UIView!
    var separatorView: UIView!
    var errorMessageContainer: UIView!
    var errorMessage: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()

        inputTextField.delegate = self
    }

    override func didMoveToSuperview() {
        addConstraints()
    }

    func setInputView(title: String, placeholder: String) {
        titleLabel.text = title
        inputTextField.placeholder = placeholder
        errorMessage.text = placeholder + " is required!"
    }

}

extension InputView: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.trimmingCharacters(in: .whitespaces) == "" {
            titleLabel.isHidden = true
            return
        }

        titleLabel.isHidden = false
        errorMessageContainer.isHidden = true

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleLabel.isHidden = false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
