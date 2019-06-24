import UIKit

extension CreateRouteViewController {
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

        nameContainer = InputView()
        stackView.addArrangedSubview(nameContainer)

        pickerContainer = UIView()
        pickerContainer.isHidden = true
        stackView.addArrangedSubview(pickerContainer)

        categoryPickerView = UIPickerView()
        pickerContainer.addSubview(categoryPickerView)

        locationContainer = UIView()
        stackView.addArrangedSubview(locationContainer)

        locationsTableView = UITableView()
        locationContainer.addSubview(locationsTableView)

        addLocationButton = UIButton()
        locationContainer.addSubview(addLocationButton)
        addLocationButton.addTarget(self, action: #selector(CreateRouteViewController.handleAddLocations), for: .touchUpInside)

        createRouteButton = UIButton()
        view.addSubview(createRouteButton)
        createRouteButton.addTarget(self, action: #selector(CreateRouteViewController.handleCreateRoute), for: .touchUpInside)

        dialogView = DialogView()
        dialogView.isHidden = true
        view.addSubview(dialogView)

        dialogView.okButton.addTarget(self, action: #selector(CreateRouteViewController.dissmisView), for: .touchUpInside)
    }

    func styleViews() {
        view.backgroundColor = .white

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        nameContainer.setInputView(title: "Route name:", placeholder: "Route name")

        infoLabel.text = "Route details:"
        infoLabel.font = infoLabel.font.withSize(30)

        view.backgroundColor = UIColor.lightBlue()

        contentView.backgroundColor = .seepSkyBlue()
        contentView.layer.cornerRadius = 25

        createRouteButton.backgroundColor = .seepSkyBlue()
        createRouteButton.setTitle("Create Route", for: .normal)

        pickerContainer.backgroundColor = .seepSkyBlue()
        pickerContainer.layer.cornerRadius = 15

        locationContainer.backgroundColor = .clear

        locationsTableView.layer.cornerRadius = 10
        locationsTableView.rowHeight = 75
        locationsTableView.sectionHeaderHeight = 0
        locationsTableView.sectionFooterHeight = 0

        addLocationButton.backgroundColor = .lightBlue()
        addLocationButton.setTitle("Add locations to route", for: .normal)
        addLocationButton.layer.cornerRadius = 15
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

        categoryPickerView.autoPinEdge(toSuperviewMargin: .top, withInset: 10)
        categoryPickerView.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        categoryPickerView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        categoryPickerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)

        locationsTableView.autoPinEdge(toSuperviewMargin: .top, withInset: 10)
        locationsTableView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        locationsTableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        locationsTableView.autoSetDimension(.height, toSize: 350)

        addLocationButton.autoSetDimension(.height, toSize: 40)
        addLocationButton.autoPinEdge(.top, to: .bottom, of: locationsTableView, withOffset: 10)
        addLocationButton.autoPinEdge(toSuperviewMargin: .bottom, withInset: 10)
        addLocationButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        addLocationButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        createRouteButton.autoPinEdge(toSuperviewEdge: .leading)
        createRouteButton.autoPinEdge(toSuperviewEdge: .trailing)
        createRouteButton.autoPinEdge(toSuperviewMargin: .bottom)
        createRouteButton.autoPinEdge(.top, to: .bottom, of: scrollView)
        createRouteButton.autoSetDimension(.height, toSize: 55)
    }
}
