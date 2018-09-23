import UIKit
import MapKit

class MapViewController: UIViewController {

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    private let name = "Apple Park Visitor Center"
    private let coordinates = CLLocationCoordinate2D(latitude: 37.3327691, longitude: -122.0055472)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        navigationItem.title = "Store Location"
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        mapView.mapType = .mutedStandard
        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.005,
                                                                                    longitudeDelta: 0.005))
        mapView.setRegion(region, animated: false)
        let point = MKPointAnnotation()
        point.coordinate = coordinates
        point.title = name
        mapView.addAnnotation(point)
    }

    @IBAction func exitButtonDidTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}
