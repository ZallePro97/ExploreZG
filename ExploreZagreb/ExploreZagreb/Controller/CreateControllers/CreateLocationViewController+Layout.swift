import UIKit
import MapKit

extension CreateLocationViewController {
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

        imageContainer = UIView()
        stackView.addArrangedSubview(imageContainer)

        addressContainer = InputView()
        stackView.addArrangedSubview(addressContainer)

        buttonContainer = UIView()
        stackView.addArrangedSubview(buttonContainer)

        seeOnMapButton = UIButton()
        buttonContainer.addSubview(seeOnMapButton)
        seeOnMapButton.addTarget(self, action: #selector(CreateLocationViewController.drawPin), for: .touchUpInside)

        mapContainer = UIView()
        stackView.addArrangedSubview(mapContainer)

        map = MKMapView()
        mapContainer.addSubview(map)

        descriptionContainer = UIView()
        stackView.addArrangedSubview(descriptionContainer)

        descriptionLabel = UILabel()
        descriptionContainer.addSubview(descriptionLabel)

        descriptionTextView = UITextView()
        descriptionContainer.addSubview(descriptionTextView)

        addImageLabel = UILabel()
        imageContainer.addSubview(addImageLabel)

        addImageButton = UIButton()
        addImageButton.addTarget(self, action: #selector(CreateLocationViewController.uploadImage), for: .touchUpInside)
        imageContainer.addSubview(addImageButton)

        confirmationLabel = UILabel()
        confirmationLabel.isHidden = true
        imageContainer.addSubview(confirmationLabel)

        createLocationButton = UIButton()
        createLocationButton.addTarget(self, action: #selector(CreateLocationViewController.handleCreateButton), for: .touchUpInside)
        view.addSubview(createLocationButton)

        dialogView = DialogView()
        dialogView.isHidden = true
        view.addSubview(dialogView)

        dialogView.okButton.addTarget(self, action: #selector(CreateLocationViewController.dissmisView), for: .touchUpInside)
    }

    func styleViews() {
        view.backgroundColor = .white

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
        stackView.spacing = 10

        addressContainer.setInputView(title: "Address:", placeholder: "Address")
        nameContainer.setInputView(title: "Name:", placeholder: "Name")

        descriptionLabel.text = "Add description:"
        descriptionTextView.text = ""
        descriptionTextView.layer.cornerRadius = 25
        descriptionContainer.backgroundColor = .clear
        descriptionLabel.backgroundColor = .clear

        mapContainer.backgroundColor = .clear
        map.layer.cornerRadius = 25

        infoLabel.text = "Location details:"
        infoLabel.font = infoLabel.font.withSize(30)

        createLocationButton.backgroundColor = .seepSkyBlue()
        createLocationButton.setTitle("Create Location", for: .normal)

        view.backgroundColor = UIColor.lightBlue()

        seeOnMapButton.backgroundColor = .lightBlue()
        seeOnMapButton.setTitle("See on Map", for: .normal)
        seeOnMapButton.layer.cornerRadius = 15

        contentView.backgroundColor = .seepSkyBlue()
        contentView.layer.cornerRadius = 25

        imageContainer.backgroundColor = .clear
        addImageLabel.text = "Click button to add image."
        confirmationLabel.text = "Image uploaded!"

        addImageButton.layer.cornerRadius = 15
        addImageButton.setTitle("Add image", for: .normal)
        addImageButton.backgroundColor = .lightBlue()
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

        descriptionLabel.autoPinEdge(toSuperviewMargin: .top, withInset: 25)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)

        descriptionTextView.autoPinEdge(toSuperviewMargin: .bottom, withInset: 25)
        descriptionTextView.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        descriptionTextView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        descriptionTextView.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 25)
        descriptionTextView.autoSetDimension(.height, toSize: 150)

        map.autoPinEdge(toSuperviewMargin: .bottom, withInset: 8)
        map.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        map.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        map.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        map.autoSetDimension(.height, toSize: 150)

        seeOnMapButton.autoPinEdge(toSuperviewMargin: .bottom, withInset: 8)
        seeOnMapButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        seeOnMapButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        seeOnMapButton.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        seeOnMapButton.autoSetDimension(.height, toSize: 40)

        addImageLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        addImageLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        addImageLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 8)

        addImageButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        addImageButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        addImageButton.autoPinEdge(.top, to: .bottom, of: addImageLabel, withOffset: 8)
        addImageButton.autoSetDimension(.height, toSize: 40)

        confirmationLabel.autoPinEdge(.top, to: .bottom, of: addImageButton, withOffset: 8)
        confirmationLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 25)
        confirmationLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 25)
        confirmationLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)

        createLocationButton.autoPinEdge(toSuperviewEdge: .leading)
        createLocationButton.autoPinEdge(toSuperviewEdge: .trailing)
        createLocationButton.autoPinEdge(toSuperviewMargin: .bottom)
        createLocationButton.autoPinEdge(.top, to: .bottom, of: scrollView)
        createLocationButton.autoSetDimension(.height, toSize: 55)
    }
}
