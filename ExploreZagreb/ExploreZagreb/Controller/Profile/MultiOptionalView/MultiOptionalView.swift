import UIKit

class MultiOptionalView: UIView {
    var backView: UIView!
    var containerView: UIView!
    var stackView: UIStackView!

    var editProfileButton: UIButton!
    var addLocationButton: UIButton!
    var addRouteButton: UIButton!

    var tapGesture: UITapGestureRecognizer!

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

    @objc
    func hideDialog() {
        isHidden = true
    }

}
