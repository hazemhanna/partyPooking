//
//  LocationVC.swift
//  Sal7ha
//
//  Created by Macbook on 12/16/19.
//  Copyright © 2019 Dtag. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var locationConfirmation: UIButton!
    
    var resultSearchController:UISearchController? = UISearchController()
    var locationFor = 0
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 300
    var perviousLocation: CLLocation?
    let geoCoder = CLGeocoder()
    var lat = Double()
    var long = Double()
    var view_controller = String()
    var selectedPin:MKPlacemark? = nil
    
    
    
    var matchingItems: [MKMapItem] = []
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var MapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationController?.setNavigationBarHidden(false, animated: true)

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        checklocationAuthorization()
        setupLocationManager()
        startTackingUserLocation()



    }
    
    
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func handleLongPress (gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint: CGPoint = gestureRecognizer.location(in: MapView)
            let newCoordinate: CLLocationCoordinate2D = MapView.convert(touchPoint, toCoordinateFrom: MapView)
            addAnnotationOnLocation(pointedCoordinate: newCoordinate)
        }
    }
    
    
    func addAnnotationOnLocation(pointedCoordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = pointedCoordinate
        
        guard let previousLocation = self.perviousLocation else { return }
        let center = CLLocation(latitude: pointedCoordinate.latitude, longitude: pointedCoordinate.longitude)
        geoCoder.reverseGeocodeLocation(center) { [weak self] (Placemark, error) in
            guard  let self = self else {return}
            if error != nil {
                print("sorry for it")
                return
                
            }
            guard  let Placemark = Placemark?.first else {
                return
            }
            
            var streetNumber = " "

            
            if Placemark.country != nil {
                
                streetNumber = streetNumber + Placemark.country! + ", "
            }
            if Placemark.thoroughfare != nil {
                streetNumber = streetNumber + Placemark.thoroughfare! + ", "
            }
            if Placemark.locality != nil {
                streetNumber = streetNumber + Placemark.locality! + ", "
            }
            if Placemark.subLocality != nil {
                
                streetNumber = streetNumber + Placemark.subLocality!

            }
            DispatchQueue.main.async {
                self.LocationLabel.text = "\(streetNumber)"
                annotation.subtitle = (Placemark.subThoroughfare ?? "") + " " + (Placemark.thoroughfare ?? "")
                annotation.title = (Placemark.subThoroughfare ?? "") + " " + (Placemark.thoroughfare ?? "")
            }
            
        }
        MapView.removeAnnotations(self.MapView.annotations)
        MapView.addAnnotation(annotation)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        MapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            MapView.setRegion(region, animated: true)
        }
    }
    
    
    @IBAction func LocationConfirmation(_ sender: Any) {
        Helper.saveLat(Lang: self.lat)
        Helper.saveLong(Lang: self.long)
        Helper.saveAddress(Lang: self.LocationLabel.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    func checklocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            MapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            
            break
        case .denied:
            locationManager.requestWhenInUseAuthorization()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedAlways:
            MapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
            
        @unknown default:
            fatalError()
        }
    }
    func startTackingUserLocation() {
        MapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        perviousLocation = getCenterLocation(for: MapView)
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(perviousLocation!) { [weak self] (Placemark, error) in
            guard  let self = self else {return}
            if error != nil {
                print("sorry for it")
                return
                
            }
            guard  let Placemark = Placemark?.first else {
                return
            }
            var streetNumber = " "

            
            if Placemark.country != nil {
                
                streetNumber = streetNumber + Placemark.country! + ", "
            }
            if Placemark.thoroughfare != nil {
                streetNumber = streetNumber + Placemark.thoroughfare! + ", "
            }
            if Placemark.locality != nil {
                streetNumber = streetNumber + Placemark.locality! + ", "
            }
            if Placemark.subLocality != nil {
                
                streetNumber = streetNumber + Placemark.subLocality!

            }
            DispatchQueue.main.async {
                self.LocationLabel.text = "\(streetNumber)"
                
            }
            
        }
    }
    
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longtitude = mapView.centerCoordinate.longitude
        self.long = longtitude
        self.lat = latitude
        UserDefaults.standard.set(self.long, forKey: "Longitude")
        UserDefaults.standard.set(self.lat, forKey: "Latitude")
        
        self.addAnnotationOnLocation(pointedCoordinate: CLLocationCoordinate2D(latitude: self.lat, longitude: self.long))
        return CLLocation(latitude: latitude, longitude: longtitude)
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checklocationAuthorization()
        } else {
            print("Please turn on your location")
        }
    }
    func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: MapView)
        let coordinate = MapView.convert(location,toCoordinateFrom: MapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        MapView.addAnnotation(annotation)
    }
    
}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checklocationAuthorization()
    }
    
}
extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = getCenterLocation(for: mapView)
        
        guard let previousLocation = self.perviousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else {return}
        perviousLocation = center
        guard self.perviousLocation != nil else {return}
        geoCoder.reverseGeocodeLocation(center) { [weak self] (Placemark, error) in
            guard  let self = self else {return}
            if error != nil {
                print("sorry for it")
                return
                
            }
            guard  let Placemark = Placemark?.first else {
                return
            }
            var streetNumber = " "

            
            if Placemark.country != nil {
                
                streetNumber = streetNumber + Placemark.country! + ", "
            }
            if Placemark.thoroughfare != nil {
                streetNumber = streetNumber + Placemark.thoroughfare! + ", "
            }
            if Placemark.locality != nil {
                streetNumber = streetNumber + Placemark.locality! + ", "
            }
            if Placemark.subLocality != nil {
                
                streetNumber = streetNumber + Placemark.subLocality!

            }
            
            DispatchQueue.main.async {
                self.LocationLabel.text = "\(streetNumber)"
            }
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated: Bool) {
        let center = getCenterLocation(for: mapView)
        
        guard let previousLocation = self.perviousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else {return}
        perviousLocation = center
        guard self.perviousLocation != nil else {return}
        geoCoder.reverseGeocodeLocation(center) { [weak self] (Placemark, error) in
            guard  let self = self else {return}
            if error != nil {
                print("sorry for it")
                return
                
            }
            guard  let Placemark = Placemark?.first else {
                return
            }
            var streetNumber = " "

            
            if Placemark.country != nil {
                
                streetNumber = streetNumber + Placemark.country! + ", "
            }
            if Placemark.thoroughfare != nil {
                streetNumber = streetNumber + Placemark.thoroughfare! + ", "
            }
            if Placemark.locality != nil {
                streetNumber = streetNumber + Placemark.locality! + ", "
            }
            if Placemark.subLocality != nil {
                
                streetNumber = streetNumber + Placemark.subLocality!

            }
            
            DispatchQueue.main.async {
                self.LocationLabel.text = "\(streetNumber)"
            }
            
        }
    }
    
}



protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

extension LocationViewController: HandleMapSearch {
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func dropPinZoomIn(placemark: MKPlacemark){
        // cache the pin
        
        dismissKeyboard()
        selectedPin = placemark
        // clear existing pins
        MapView.removeAnnotations(MapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        var streetNumber = " "

        if placemark.country != nil {
            
            streetNumber = streetNumber + placemark.country! + ", "
        }
        if placemark.thoroughfare != nil {
            streetNumber = streetNumber + placemark.thoroughfare! + ", "
        }
        if placemark.locality != nil {
            streetNumber = streetNumber + placemark.locality! + ", "
        }
        if placemark.subLocality != nil {
            
            streetNumber = streetNumber + placemark.subLocality!

        }
        
        DispatchQueue.main.async {
            self.LocationLabel.text = "\(streetNumber)"
        }
        MapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            MapView.setRegion(region, animated: true)
        }
}

