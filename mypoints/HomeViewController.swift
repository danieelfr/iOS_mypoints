import UIKit
import CoreLocation
import MapKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var locationManager: CLLocationManager = {
        
        var lmanager = CLLocationManager()
        lmanager.delegate = self
        lmanager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        lmanager.activityType = .otherNavigation
        lmanager.distanceFilter = 10.0
        
        return lmanager
    }()
    
    var pointsList: [(pointName:String, local:String, latitude:String, longitude:String)] = []
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PointsListCustomCell
        
        cell.lblPointName.text = pointsList[indexPath.row].pointName
        cell.lblLocal.text = pointsList[indexPath.row].local
        cell.lblLatitude.text = pointsList[indexPath.row].latitude
        cell.lblLongitude.text = pointsList[indexPath.row].longitude
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pointsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let latitude = Double(pointsList[indexPath.row].latitude)
        let longitude = Double(pointsList[indexPath.row].longitude)
        let pointName = pointsList[indexPath.row].pointName
        let local = pointsList[indexPath.row].local
        
        self.markMapPoint(latitude: latitude!, longitude: longitude!, pointName: pointName, local: local)
    }
    
    func markMapPoint(latitude:Double, longitude:Double, pointName:String, local:String)
    {
        var loc:CLLocationCoordinate2D = CLLocationCoordinate2D()
        loc.latitude = CLLocationDegrees(latitude)
        loc.longitude = CLLocationDegrees(longitude)

        let cam:MKMapCamera = MKMapCamera()
        cam.altitude = pow(2,10)
        cam.centerCoordinate = loc
        mapView.setCamera(cam, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = loc
        annotation.title = pointName
        
       
        mapView.addAnnotation(annotation)
    }
    
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


