//
//  PhotoInfoViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import MapKit
import UIKit

class PhotoInfoViewController: UIViewController {

    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var locationIconImageView: UIImageView!
    @IBOutlet private weak var photoDescriptionLabel: UILabel!
    @IBOutlet private weak var makeLabel: UILabel!
    @IBOutlet private weak var modelLabel: UILabel!
    @IBOutlet private weak var shutterSpeedLabel: UILabel!
    @IBOutlet private weak var apertureLabel: UILabel!
    @IBOutlet private weak var focalLengthLabel: UILabel!
    @IBOutlet private weak var isoLabel: UILabel!
    @IBOutlet private weak var dimensionLabel: UILabel!
    @IBOutlet private weak var publishedLabel: UILabel!
    
    @IBOutlet private weak var mapView: MKMapView! {
        didSet {
            self.mapView.delegate = self
        }
    }
    
    var photoViewModel: PhotoViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoViewModel?.getPhotoData()
        makeLabel.text = photoViewModel?.photoMake
        modelLabel.text = photoViewModel?.photoModel
        shutterSpeedLabel.text = photoViewModel?.photoShutterSpeed
        apertureLabel.text = photoViewModel?.photoAperture
        focalLengthLabel.text = photoViewModel?.photoFocalLength
        isoLabel.text = photoViewModel?.photoISO
        dimensionLabel.text = photoViewModel?.photoDimension
        publishedLabel.text = photoViewModel?.photoPublishedDate
        guard let photoLocationText = photoViewModel?.photoLocation else {
            return
        }
        if photoLocationText.isEmpty {
            locationLabel.removeFromSuperview()
            photoDescriptionLabel.removeFromSuperview()
            locationIconImageView.removeFromSuperview()
            mapView.removeFromSuperview()
        } else {
            photoDescriptionLabel.text = photoViewModel?.photoDescription
            locationLabel.text = photoLocationText
            photoViewModel?.setAnnotation(on: mapView)
        }
    }
    
    @IBAction private func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PhotoInfoViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
        }
        return view
    }
}
