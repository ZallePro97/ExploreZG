import UIKit
import MapKit
import FirebaseStorage

class CreateLocationViewController: UIViewController {

    private var appService: AppService!
    private var appRouter: AppRouter!

    private var longitute: Double?
    private var latitute: Double?
    private var imagePath: String?

    var dialogView: DialogView!
    var error: Bool = false

    var scrollView: UIScrollView!
    var cardView: UIView!
    var contentView: UIView!
    var stackView: UIStackView!

    var infoLabel: UILabel!

    var nameContainer: InputView!
    var addressContainer: InputView!
    var buttonContainer: UIView!
    var seeOnMapButton:UIButton!
    var mapContainer: UIView!
    var map: MKMapView!
    var descriptionContainer: UIView!
    var descriptionLabel: UILabel!
    var descriptionTextView: UITextView!

    var imageContainer: UIView!
    var addImageLabel: UILabel!
    var addImageButton: UIButton!
    var confirmationLabel: UILabel!

    var createLocationButton: UIButton!

    var selectedImage: Data?
    var imageUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        descriptionTextView.delegate = self
    }

    convenience init(appService: AppService, appRouter: AppRouter) {
        self.init()

        self.appService = appService
        self.appRouter = appRouter
    }

    @objc
    func drawPin() {
        guard let address = addressContainer.inputTextField
            .text?
            .trimmingCharacters(in: .whitespaces),
            address != ""
        else {
            self.error = true
            showDialog(withMessage: "Can't find location for empty address.")
            return
        }

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = address

        let activeSearch = MKLocalSearch(request: searchRequest)

        activeSearch.start { (response, error) in
            guard let response = response else {
                self.error = true
                self.showDialog(withMessage: "Can't find location.")
                return
            }

            let annotations = self.map.annotations
            self.map.removeAnnotations(annotations)

            self.longitute = response.boundingRegion.center.longitude
            self.latitute = response.boundingRegion.center.latitude

            let annotation = MKPointAnnotation()
            annotation.title = address
            annotation.coordinate = CLLocationCoordinate2DMake(self.latitute!, self.longitute!)
            self.map.addAnnotation(annotation)

            let location = CLLocationCoordinate2DMake(self.latitute!, self.longitute!)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: location, span: span)
            self.map.setRegion(region, animated: true)
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

    @objc
    func handleCreateButton() {
        guard let name = nameContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces),
            let address = addressContainer.inputTextField.text?.trimmingCharacters(in: .whitespaces)
        else {
            error = true
            showDialog(withMessage: "Name or address can be nil.")
            return
        }

        guard let imageUrl = imageUrl else {
            error = true
            showDialog(withMessage: "Image is required!")
            return
        }


        let description = descriptionTextView.text.trimmingCharacters(in: .whitespaces)

        var anyEmpty = false

        if name.isEmpty {
            nameContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if address.isEmpty {
            addressContainer.errorMessageContainer.isHidden = false
            anyEmpty = true
        }

        if anyEmpty { return }

        if longitute == nil || latitute == nil {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = address

            let activeSearch = MKLocalSearch(request: searchRequest)

            activeSearch.start { (response, error) in
                guard let response = response else {
                    self.error = true
                    self.showDialog(withMessage: "Can't find location.")
                    return
                }

                let annotations = self.map.annotations
                self.map.removeAnnotations(annotations)

                self.longitute = response.boundingRegion.center.longitude
                self.latitute = response.boundingRegion.center.latitude

                let location = LocationModel(id: 0, name: name, picturePath: imageUrl, latitude: self.latitute!, longitude: self.longitute!, address: address, description: description, wikiLink: "")

                self.appService.createLocation(location: location, completion: { _ in
                    self.navigationController?.popViewController(animated: true)
                })
            }
        } else {
            let location = LocationModel(id: 0, name: name, picturePath: imageUrl, latitude: latitute!, longitude: longitute!, address: address, description: description, wikiLink: "")

            self.appService.createLocation(location: location, completion: { _ in
                self.navigationController?.popViewController(animated: true)
            })
        }


    }

    @objc
    func uploadImage() {
        let picker = UIImagePickerController()

        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary

        present(picker, animated: true, completion: nil)
    }

    func addImageToStorage(picturePath: UUID) {
        guard let imageData = selectedImage else { return }

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/\(picturePath).png")
        _ = imageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
            if error != nil {
                self.error = true
                self.showDialog(withMessage: "Error happend while uploading image")
                return
            }

            imageRef.downloadURL(completion: { (url, error) in
                if let url = url {
                    self.imageUrl = url.absoluteString
                }
            })
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = false
    }

}

extension CreateLocationViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }

        return true
    }
}

extension CreateLocationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage{
            if editedImage.size.height > 1000 && editedImage.size.width > 1000 {
                selectedImage = editedImage.resizeWithPercent(percentage: 0.1)!.pngData()
            } else {
                selectedImage = editedImage.pngData()
            }
        } else if let originalImage = info[.originalImage] as? UIImage {
            if originalImage.size.height > 1000 && originalImage.size.width > 1000 {
                selectedImage = originalImage.resizeWithPercent(percentage: 0.1)!.pngData()
            } else {
                selectedImage = originalImage.pngData()
            }
        }

        if selectedImage != nil {
            confirmationLabel.isHidden = false
        }

        addImageToStorage(picturePath: UUID())
        picker.dismiss(animated: true, completion: nil)
    }
}
