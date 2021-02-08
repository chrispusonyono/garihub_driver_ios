//
//  DashboardController.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
class DashboardController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var firstTimeHolder: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var closeFirstTimeGoOnline: UIImageView!
    @IBOutlet weak var welcomePerson: UILabel!
    var rejected = false
    var viewModel: DashboardViewModel?

    @IBOutlet weak var navigationDrawer: UIImageView!
    @IBOutlet weak var goOnlineBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
    override func viewDidAppear(_ animated: Bool) {
        setUpUI()
    }
    private func initialize(){
            let Profile = UITapGestureRecognizer(target: self, action: #selector(self.goToProfile(_:)))
            navigationDrawer.addGestureRecognizer(Profile)
            navigationDrawer.isUserInteractionEnabled = true
        
        let closePopup = UITapGestureRecognizer(target: self, action: #selector(self.closeFirstTime(_:)))
        closeFirstTimeGoOnline.addGestureRecognizer(closePopup)
        closeFirstTimeGoOnline.isUserInteractionEnabled = true
            
            //let alertController = UIAlertController(title: "Error", message: "Invalid map configuration", preferredStyle: .alert)
    //     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

      //      alertController.addAction(defaultAction)
            //self.present(alertController, animated: true, completion: nil)
            let camera = GMSCameraPosition.camera(withLatitude: -1.102554, longitude: 37.013193, zoom: 15.0)

            mapView.camera = camera
            mapView.frame = CGRect.zero
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: -1.102554, longitude: 37.013193)
            marker.title = "Your Location"
            marker.snippet = "JUJA"
            marker.map = mapView
        }
    @IBAction func goOnline(_ sender: Any) {
        askPermissionFirst()
        let request = Request(id: "1", mobile: "0700824555", name: "Chrispus Onyono", pickup: "Juja", destination: "Java Westlands", rating: "2.5", profilePicturePath: "https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg", status: "0", pickupLatLong: "-1.102554,37.013193", destinationLatLong: "-1.102554,37.013193")
        Constant.DATA.REQUEST.append(request!)
        self.viewModel?.router.trigger(.riderRequest)
    }
    private func connectWithSockets(){
        
    }
    private func showRiderRequest(){
        
    }
    private func showOnlinepPop(){
        
    }
    func askPermissionFirst(){
    if !hasLocationPermission() {
                if rejected {
                let alertController = UIAlertController(title: "Oops!", message: "You rejected app from accessing your location, to get rides nearby you have to enable permissions in settings", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                    //Redirect to Settings app
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                    
                }else{
                    
                    let locationManager = CLLocationManager()
                    locationManager.delegate = self
                    locationManager.requestWhenInUseAuthorization()
    //
    //                let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
    //                let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
    //                    //Redirect to Settings app
    //                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
    //                })
    //                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
    //                alertController.addAction(cancelAction)
    //                alertController.addAction(okAction)
    //                self.present(alertController, animated: true, completion: nil)
                }
            }
    }
    private func setUpUI(){
        
    }

    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
            case .denied:
                hasPermission = false
            @unknown default:
                hasPermission = false
            }
        } else {
            hasPermission = false
        }

        return hasPermission
    }
    @objc func goToProfile(_ sender: UITapGestureRecognizer) {
        self.viewModel?.router.trigger(.profile(fullName: "Chrispus Onyono",email: "chrispusonyono@gmail.com",mobile: "0700824555"))
       }
    @objc func closeFirstTime(_ sender: UITapGestureRecognizer) {
        self.firstTimeHolder.isHidden = !self.firstTimeHolder.isHidden
          }
}
