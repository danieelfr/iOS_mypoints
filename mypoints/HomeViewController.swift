import UIKit
import CoreLocation
import MapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var locationManager: CLLocationManager = {
        
        var lmanager = CLLocationManager()
        lmanager.delegate = self
        lmanager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        lmanager.activityType = .otherNavigation
        lmanager.distanceFilter = 10.0
        
        return lmanager
    }()
    
    var pointsList = [Point]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointsList = PointsBusiness().getFakePointsList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        locationManager.requestAlwaysAuthorization()
        
        mapView.isPitchEnabled = true
        mapView.isZoomEnabled = true
        mapView.isRotateEnabled = true
        mapView.isScrollEnabled = true
        
        if let location = locationManager.location?.coordinate {
            
            mapView.setCenter(location, animated: true)
            mapView.centerCoordinate.latitude = location.latitude
            mapView.centerCoordinate.longitude = location.longitude
            mapView.camera.altitude = pow(2,11)
            
        } else {
            
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func markMapPoint(point:Point)
    {
        var loc:CLLocationCoordinate2D = CLLocationCoordinate2D()
        loc.latitude = CLLocationDegrees(Double(point.Latitude)!)
        loc.longitude = CLLocationDegrees(Double(point.Longitude)!)

        let cam:MKMapCamera = MKMapCamera()
        cam.altitude = pow(2,10)
        cam.centerCoordinate = loc
        mapView.setCamera(cam, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = loc
        annotation.title = point.Name
        
        mapView.addAnnotation(annotation)
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PointsListCustomCell
        
        cell.lblPointName.text = pointsList[indexPath.row].Name
        cell.lblLocal.text = pointsList[indexPath.row].Local
        cell.lblLatitude.text = pointsList[indexPath.row].Latitude
        cell.lblLongitude.text = pointsList[indexPath.row].Longitude
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pointsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Latitude = pointsList[indexPath.row].Latitude
        let Longitude = pointsList[indexPath.row].Longitude
        let Name = pointsList[indexPath.row].Name
        let Local = pointsList[indexPath.row].Local
        
        let SelectedPoint = Point(Name: Name, Local: Local, Latitude: Latitude, Longitude: Longitude)
        
        self.markMapPoint(point: SelectedPoint)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocation!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            
            mapView.showsUserLocation = true
            
            if let location = locationManager.location?.coordinate {
                
                mapView.setCenter(location, animated: true)
                mapView.camera.altitude = pow(2,11)
                
            } else {
                
                locationManager.startUpdatingLocation()
            }
        }
    }
}
