//
//  LocationViewController.swift
//  PartyBooking
//
//  Created by MAC on 7/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import GoogleMaps


class LocationViewController: UIViewController{
    
    @IBOutlet weak var dateImage: UIView!
    @IBOutlet weak var googlemap : GMSMapView!
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.setImage(backButton.currentImage?.flipIfNeeded(), for: .normal)
        }
    }
    
    
    
    var locationManager = CLLocationManager()
    var marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateImage.layer.cornerRadius=7
        dateImage.layer.borderColor=UIColor.white.cgColor
        dateImage.layer.borderWidth=1
        chooseBtn.layer.cornerRadius = 20
        googlemap.mapType = .normal
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }else{
            print("error ")
        }
        setUPLocalize()
    }
    
    
    func setUPLocalize(){
        chooseBtn.setTitle("choose".localized, for: .normal)
        if MOLHLanguage.currentAppleLanguage() == "en" {
            chooseBtn.titleLabel!.font = UIFont(name: "Georgia-Bold", size: 17)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension LocationViewController : CLLocationManagerDelegate, GMSMapViewDelegate  {
    
    //Fires when the user Allow/Doesn't allow the permission of getting the current location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //Check if the user allowed us to access the current location
        if status == .authorizedWhenInUse {
            //Show "My Current Location" to the user
            googlemap.isMyLocationEnabled = true
            googlemap.settings.myLocationButton = true
        }
    }
    //////// get user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        ///// get  lat, long
        let location = locations.first! as CLLocation
        _ = location.coordinate.latitude
        _ = location.coordinate.longitude
        // change camera position
        googlemap.camera = GMSCameraPosition(target: location.coordinate, zoom: 17, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
        /// marker
        self.marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude,longitude : location.coordinate.longitude)
        self.marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        self.marker.appearAnimation = .pop
        self.marker.isFlat = true
        self.marker.icon = UIImage(named:"location")
        self.marker.map = self.googlemap
        
        
    }
    
    
    
}
