//
//  DashboardController.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit
import CoreLocation
import ImageLoader
import GoogleMaps
import Toast_Swift
import Starscream
class DashboardController: UIViewController, CLLocationManagerDelegate, WebSocketDelegate {
    @IBOutlet weak var firstTimeHolder: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var closeFirstTimeGoOnline: UIImageView!
    @IBOutlet weak var welcomePerson: UILabel!
    let profile = Constant.getUserProfile()
    var rejected = false
    var isConnected = false

    @IBOutlet weak var navigationDrawer: UIImageView!
    @IBOutlet weak var goOnlineBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        
        initialize()
        setUpUI()
    }
    private func initialize(){
        if(Constant.justLoggedIn){
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                self.firstTimeHolder.isHidden = false
                self.welcomePerson.text = "Welcome \(self.profile.name)!"
            }
        }
            
        
        self.profileImage.load.request(with: profile.profilePicturePath)
        
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
            let camera = GMSCameraPosition.camera(withLatitude: -1.102554, longitude: 37.013193, zoom: 20.0)

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
        //let request = Request(id: "1", mobile: "0700824555", name: "Chrispus Onyono", pickup: "Juja", destination: "Java Westlands", rating: "2.5", profilePicturePath: "https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg", status: "0", pickupLatLong: "-1.102554,37.013193", destinationLatLong: "-1.102554,37.013193")
        //Constant.DATA.REQUEST = request
        
        connectWithSockets()
    }
    private func connectWithSockets(){
       showLoading(load: true)
        var request = URLRequest(url: URL(string: Constant.WebSocketURL)!)
        request.timeoutInterval = 5 // Sets the timeout for the connection
        request.setValue("client-id", forHTTPHeaderField: "")
        Constant.socket = WebSocket(request: request)
        Constant.socket?.delegate = self
        Constant.socket?.connect()
        
    }
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
            self.showLoading(load: false)
            self.view.makeToast("You are now online")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            self.view.makeToast(error.debugDescription)
        
        }
    }
    private func showRiderRequest(){
        
    }
    private func showOnlinepPop(){
        
    }
    private func moveDriver(){
        Constant.socket!.write(string: "{\"requestType\": \"LOCATION_UPDATE\",\"to\": \"to-identifier\",\"from\": \"from-identifier\",\"vehicleId\": 6,\"vehicle\": {\"vehicleLat\": \"-1.1734308\",\"vehicleLon\": \"36.9154656\",\"vehicleBearing\": \"0.000000\"}}")
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
    private func showLoading(load:Bool) -> Void {
        if load{
            self.view.makeToastActivity(.center)}
        else{
            self.view.hideToastActivity()
        }
    }
    private func setUpUI(){
        profileImage.makeRounded()
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
        
        
        //self.navigationController!.pushViewController(MainController(nibName: "MainController", bundle: nil), animated: true)
        
        let vc = MainController(nibName: "MainController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
       }
    @objc func closeFirstTime(_ sender: UITapGestureRecognizer) {
        self.firstTimeHolder.isHidden = !self.firstTimeHolder.isHidden
          }
}
