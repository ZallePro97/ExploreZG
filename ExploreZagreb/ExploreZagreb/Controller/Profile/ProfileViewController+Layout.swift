import UIKit

extension ProfileViewController {

    func buildViews() {
        createViews()
        styleViews()
        addConstrains()
    }

    func createViews() {
        contentView = UIView()
        view.addSubview(contentView)

        containerView = UIView()
        contentView.addSubview(containerView)

        profileImage = UIImageView()
        containerView.addSubview(profileImage)

        usernameLabel = UILabel()
        containerView.addSubview(usernameLabel)

        userInfo = UILabel()
        containerView.addSubview(userInfo)

        favoritesLabel = UILabel()
        containerView.addSubview(favoritesLabel)

        favoritesTableView = UITableView()
        containerView.addSubview(favoritesTableView)

        optionsButton = UIButton()
        contentView.addSubview(optionsButton)
        optionsButton.addTarget(self, action: #selector(ProfileViewController.showDialog), for: .touchUpInside)
        
        multiOptionalView = MultiOptionalView()
        multiOptionalView.isHidden = true
        view.addSubview(multiOptionalView)

        multiOptionalView.editProfileButton.addTarget(self, action: #selector(ProfileViewController.navigateToEditProfile), for: .touchUpInside)
        multiOptionalView.addLocationButton.addTarget(self, action: #selector(ProfileViewController.navigateToAddLocation), for: .touchUpInside)
        multiOptionalView.addRouteButton.addTarget(self, action: #selector(ProfileViewController.navigateToAddRoute), for: .touchUpInside)
    }

    func styleViews() {
        view.backgroundColor = .lightBlue()

        containerView.backgroundColor = .seepSkyBlue()
        containerView.layer.cornerRadius = 25

        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 37.5
        profileImage.contentMode = .scaleAspectFill

        usernameLabel.textAlignment = .center
        userInfo.textAlignment = .center

        favoritesTableView.layer.cornerRadius = 10
        favoritesTableView.rowHeight = 75
        favoritesTableView.sectionHeaderHeight = 0
        favoritesTableView.sectionFooterHeight = 0

        optionsButton.setTitle("Options", for: .normal)

        favoritesLabel.text = "Favorites:"
    }

    func addConstrains() {
        contentView.autoPinEdge(toSuperviewEdge: .leading)
        contentView.autoPinEdge(toSuperviewEdge: .trailing)
        contentView.autoPinEdge(toSuperviewMargin: .top)
        contentView.autoPinEdge(toSuperviewMargin: .bottom)

        optionsButton.autoSetDimension(.height, toSize: 40)
        optionsButton.autoPinEdge(toSuperviewEdge: .top)
        optionsButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        containerView.autoPinEdge(.top, to: .bottom, of: optionsButton)
        containerView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        containerView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        containerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 25)

        profileImage.autoPinEdge(toSuperviewEdge: .top, withInset: 35)
        profileImage.autoAlignAxis(toSuperviewAxis: .vertical)
        profileImage.autoSetDimensions(to: CGSize(width: 75, height: 75))

        usernameLabel.autoPinEdge(.top, to: .bottom, of: profileImage, withOffset: 10)
        usernameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        usernameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        userInfo.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 10)
        userInfo.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        userInfo.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        favoritesLabel.autoPinEdge(.top, to: .bottom, of: userInfo, withOffset: 20)
        favoritesLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        favoritesLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        favoritesTableView.autoPinEdge(.top, to: .bottom, of: favoritesLabel, withOffset: 10)
        favoritesTableView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        favoritesTableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        favoritesTableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 25)
    }
}
