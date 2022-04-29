//
//  SettingsViewController.swift
//  malone-swift-app
//
//  Created by Carter Brehm on 4/28/22.
//

import UIKit
import MapKit

class SettingsViewController: UIViewController {
    
    let initialLocation = CLLocation(latitude: 40.820154, longitude: -96.6910366)
    let mapsLocation = CLLocationCoordinate2D(latitude: 40.820154, longitude: -96.6910366)

    @IBOutlet weak var phoneButton: UIButton!
    
    @IBAction func phoneButtonClicked(_ sender: Any) {
        if let phoneCallURL = URL(string: "tel://4024741110") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
          }
    }
    @IBAction func mapButtonClicked(_ sender: Any) {
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        let placemark = MKPlacemark(coordinate: mapsLocation, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Malone Community Center"
        mapItem.openInMaps(launchOptions: options)
    }
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.centerToLocation(initialLocation)
        
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        
        let malone = MKPointAnnotation()
        malone.title = "Malone Community Center"
        malone.coordinate = mapsLocation
        mapView.addAnnotation(malone)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is MKPointAnnotation else { return nil }

    let identifier = "Annotation"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

    if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView!.canShowCallout = true
    } else {
        annotationView!.annotation = annotation
    }

    return annotationView
}
