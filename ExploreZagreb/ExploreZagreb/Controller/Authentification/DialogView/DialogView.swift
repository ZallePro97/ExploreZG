import UIKit

class DialogView: UIView {

    var backView: UIView!
    var containerView: UIView!
    var messageLabel: UILabel!
    var okButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }

    override func didMoveToSuperview() {
        addConstraints()
    }
}
