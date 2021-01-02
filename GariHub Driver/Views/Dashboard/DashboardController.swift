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
    var rejected = false
    var viewModel: DashboardViewModel?

    @IBOutlet weak var navigationDrawer: UIImageView!
    @IBOutlet weak var goOnlineBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }
    private func initialize(){
        let Profile = UITapGestureRecognizer(target: self, action: #selector(self.goToProfile(_:)))
        navigationDrawer.addGestureRecognizer(Profile)
        navigationDrawer.isUserInteractionEnabled = true
        
        //let alertController = UIAlertController(title: "Error", message: "Invalid map configuration", preferredStyle: .alert)
//     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

  //      alertController.addAction(defaultAction)
        //self.present(alertController, animated: true, completion: nil)
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //view = mapView
        
    }
    @IBAction func goOnline(_ sender: Any) {
        askPermissionFirst()
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
}
