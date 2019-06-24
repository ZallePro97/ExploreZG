import UIKit
import ChameleonFramework

class PinLocationDetailsViewController: UIViewController {
    
    let nameLabel = UILabel.newAutoLayout()
    let addressLabel = UILabel.newAutoLayout()
    let descriptionLabel = UILabel.newAutoLayout()
    
    let image = UIImageView.newAutoLayout()
    
    var location: LocationModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.flatWhite()
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setUI() {
        view.backgroundColor = .lightBlue()

        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        if let url = URL(string: location.picturePath) {
            image.kf.setImage(with: url)
        }
        self.view.addSubview(image)
        
        nameLabel.text = location.name
        nameLabel.textColor = .white
        nameLabel.backgroundColor = UIColor.seepSkyBlue()
        nameLabel.font = nameLabel.font.withSize(18)
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 10
        self.view.addSubview(nameLabel)
        
        if location.address.contains(",") {
            addressLabel.text = String(location.address.split(separator: ",")[0])
        } else {
            addressLabel.text = "Zagreb"
        }
        addressLabel.textColor = .white
        addressLabel.backgroundColor = UIColor.seepSkyBlue()
        addressLabel.font = addressLabel.font.withSize(18)
        addressLabel.textAlignment = .center
        addressLabel.adjustsFontSizeToFitWidth = true
        addressLabel.layer.masksToBounds = true
        addressLabel.layer.cornerRadius = 10
        self.view.addSubview(addressLabel)
        
        descriptionLabel.text = location.description
        descriptionLabel.textColor = .white
        descriptionLabel.backgroundColor = UIColor.seepSkyBlue()
        descriptionLabel.font = descriptionLabel.font.withSize(18)
        descriptionLabel.textAlignment = .center
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.layer.masksToBounds = true
        descriptionLabel.layer.cornerRadius = 10
        self.view.addSubview(descriptionLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        image.autoPinEdge(toSuperviewEdge: .top, withInset: navigationController?.navigationBar.frame.size.height ?? 100)
        image.autoPinEdge(toSuperviewEdge: .bottom, withInset: UIScreen.main.bounds.height * (3 / 5))
        image.autoPinEdge(toSuperviewEdge: .leading)
        image.autoPinEdge(toSuperviewEdge: .trailing)
        
        nameLabel.autoPinEdge(.top, to: .bottom, of: image, withOffset: 25)
        nameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        nameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        addressLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 25)
        addressLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        addressLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        descriptionLabel.autoPinEdge(.top, to: .bottom, of: addressLabel, withOffset: 25)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        descriptionLabel.autoPinEdge(toSuperviewMargin: .bottom)
        
    }

}
