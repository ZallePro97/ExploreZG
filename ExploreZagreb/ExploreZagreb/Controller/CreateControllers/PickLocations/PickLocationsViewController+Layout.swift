import UIKit

extension PickLocationsViewController {
    func buildViews() {
        createViews()
        styleViews()
        addConstrains()
    }

    func createViews() {
        infoLabel = UILabel()
        view.addSubview(infoLabel)

        cardView = UIView()
        view.addSubview(cardView)

        contentView = UIView()
        cardView.addSubview(contentView)

        locationsTableView = UITableView()
        cardView.addSubview(locationsTableView)

        saveLocationsButton = UIButton()
        view.addSubview(saveLocationsButton)
        saveLocationsButton.addTarget(self, action: #selector(PickLocationsViewController.saveLocations), for: .touchUpInside)

        dialogView = DialogView()
        dialogView.isHidden = true
        view.addSubview(dialogView)

        dialogView.okButton.addTarget(self, action: #selector(PickLocationsViewController.dissmisView), for: .touchUpInside)
    }

    func styleViews() {
        view.backgroundColor = .white

        infoLabel.text = "Select locations:"
        infoLabel.font = infoLabel.font.withSize(30)

        view.backgroundColor = UIColor.lightBlue()

        contentView.backgroundColor = .seepSkyBlue()
        contentView.layer.cornerRadius = 25

        locationsTableView.layer.cornerRadius = 10
        locationsTableView.rowHeight = 75
        locationsTableView.sectionHeaderHeight = 0
        locationsTableView.sectionFooterHeight = 0

        saveLocationsButton.backgroundColor = .lightBlue()
        saveLocationsButton.setTitle("Add locations to route", for: .normal)
        saveLocationsButton.layer.cornerRadius = 15
    }

    func addConstrains() {
        infoLabel.autoPinEdge(toSuperviewMargin: .top, withInset: 25)
        infoLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        infoLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        cardView.autoPinEdge(toSuperviewEdge: .leading)
        cardView.autoPinEdge(toSuperviewEdge: .trailing)
        cardView.autoPinEdge(.top, to: .bottom, of: infoLabel)

        contentView.autoPinEdge(toSuperviewMargin: .top, withInset: 10)
        contentView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        contentView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        contentView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)

        locationsTableView.autoPinEdge(toSuperviewMargin: .top, withInset: 50)
        locationsTableView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        locationsTableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        locationsTableView.autoPinEdge(toSuperviewMargin: .bottom, withInset: 50)

        saveLocationsButton.autoPinEdge(toSuperviewEdge: .leading)
        saveLocationsButton.autoPinEdge(toSuperviewEdge: .trailing)
        saveLocationsButton.autoPinEdge(toSuperviewMargin: .bottom)
        saveLocationsButton.autoPinEdge(.top, to: .bottom, of: cardView)
        saveLocationsButton.autoSetDimension(.height, toSize: 55)
    }
}
