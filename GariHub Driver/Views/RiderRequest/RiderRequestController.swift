//
//  RiderRequestController.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 07/12/2020.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit
import ImageLoader
import Toast_Swift
import CoreLocation
import GoogleMaps
class RiderRequestController: UIViewController {

    @IBOutlet weak var requestContainer: UIView!
    @IBOutlet weak var requestHeightMultiplier: NSLayoutConstraint!
    @IBOutlet weak var contactHeight: NSLayoutConstraint!
    @IBOutlet weak var requestHolder: UIView!
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var reject: UIButton!
    @IBOutlet weak var iHaveArrived: UIButton!
    @IBOutlet weak var endTrip: UIButton!
    @IBOutlet weak var startTrip: UIButton!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var call: UIButton!
    @IBOutlet weak var contactHolder: UIView!
    @IBOutlet weak var requestMap: GMSMapView!
    
    //======== Rating Parameter =========//
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pickupDestination: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    private let request =  Constant.DATA.REQUEST!
    var polyline = GMSPolyline()
    var animationPolyline = GMSPolyline()
    var path = GMSPath()
    var animationPath = GMSMutablePath()
    var i: UInt = 0
    var timer: Timer!
    	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        initialize()
    }

    private func initialize(){
        let pickupCord = CLLocationCoordinate2D(latitude: -1.142666096, longitude: 36.95416285)
        let destinCord = CLLocationCoordinate2D(latitude: -1.2879, longitude: 36.9729)
        getRoute(src: pickupCord, dst: destinCord)
        changeRideTo(state: "new_ride")
        
    }
    func getRoute(src: CLLocationCoordinate2D, dst: CLLocationCoordinate2D){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(src.latitude),\(src.longitude)&destination=\(dst.latitude),\(dst.longitude)&sensor=false&mode=driving&key=\(Constant.GoogleMapApiKey)")!

        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        DispatchQueue.main.async(execute: {
                            let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: src, coordinate: dst))
                             self.requestMap.moveCamera(cameraUpdate)
                            let currentZoom = self.requestMap.camera.zoom
                            self.requestMap.animate(toZoom: currentZoom - 1.4)
                            self.drawRoute(routeDict: json)
                        })
                        
//                        let preRoutes = json["routes"] as! NSArray
//                        let routes = preRoutes[0] as! NSDictionary
//                        let routeOverviewPolyline:NSDictionary = routes.value(forKey: "overview_polyline") as! NSDictionary
//                        let polyString = routeOverviewPolyline.object(forKey: "points") as! String
//
//                        DispatchQueue.main.async(execute: {
//                            let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: src, coordinate: dst))
//                            self.requestMap.moveCamera(cameraUpdate)
//                            let currentZoom = self.requestMap.camera.zoom
//                            self.requestMap.animate(toZoom: currentZoom - 1.4)
//
//                            let path = GMSPath(fromEncodedPath: polyString)
//                            let polyline = GMSPolyline(path: path)
//                            polyline.strokeWidth = 5.0
//                            polyline.strokeColor = UIColor.green
//                            polyline.map = self.requestMap
//
//
//
//                        })
                    }

                } catch {
                    print("parsing error")
                }
            }
        })
        task.resume()
    }
    private func contact(hide: Bool){
        let realWidth = requestHolder.frame.width
        let realHeight = realWidth * 1.2
        let itemheight = realHeight/3
        
        if (hide){
//            let newConstraint = requestHeightMultiplier.constraintWithMultiplier(0.6)
//            requestHolder.removeConstraint(requestHeightMultiplier)
//            requestHolder.addConstraint(newConstraint)
//            requestHolder.layoutIfNeeded()
//            requestHeightMultiplier = newConstraint
            
            contactHeight.constant =  0
            contactHolder.isHidden = true
        }else{
            
//            let newConstraint = requestHeightMultiplier.constraintWithMultiplier(0.65)
//            requestHolder.removeConstraint(requestHeightMultiplier)
//            requestHolder.addConstraint(newConstraint)
//            requestHolder.layoutIfNeeded()
//            requestHeightMultiplier = newConstraint
            
            contactHeight.constant = itemheight/2
            contactHolder.isHidden = false
            
        }
        self.view.layoutIfNeeded()
        self.requestHolder.layoutIfNeeded()
        
    }
    private func setupUI(){
        
        profileImage.makeRounded()
        accept.layer.cornerRadius = 10.0
        message.layer.cornerRadius = 10.0
        reject.layer.cornerRadius = 10.0
        call.layer.cornerRadius = 10.0
        iHaveArrived.layer.cornerRadius = 10.0
        endTrip.layer.cornerRadius = 10.0
        startTrip.layer.cornerRadius = 10.0
        requestHolder.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        
        reject.layer.borderWidth = 2.0
        call.layer.borderWidth = 2.0
        
        accept.clipsToBounds = true
        message.clipsToBounds = true
        reject.clipsToBounds = true
        call.clipsToBounds = true
        iHaveArrived.clipsToBounds = true
        endTrip.clipsToBounds = true
        startTrip.clipsToBounds = true
        requestHolder.clipsToBounds = true
        
        accept.layer.masksToBounds = true
        message.layer.masksToBounds = true
        reject.layer.masksToBounds = true
        call.layer.masksToBounds = true
        iHaveArrived.layer.masksToBounds = true
        endTrip.layer.masksToBounds = true
        startTrip.layer.masksToBounds = true
        
        
        reject.layer.borderColor = UIColor.systemYellow.cgColor
        call.layer.borderColor = UIColor.systemYellow.cgColor
        
        locationLabel.text = "Pickup Location: "
        pickupDestination.text = request.destination
        rating.text = request.rating
        name.text = request.name
        time.text = "3 Mins"
        profileImage.load.request(with: request.profilePicturePath)
        requestContainer.isHidden = true
        
    }

    @IBAction func acceptRideFromRider(_ sender: Any) {
        changeRideTo(state: "i_have_arrived")
        
    }
    @IBAction func ihaveArrived(_ sender: Any) {
        changeRideTo(state: "start_trip")
               
    }
    @IBAction func swipeToStart(_ sender: Any) {
        changeRideTo(state: "end_trip")
               
    }
    @IBAction func swipeToEnd(_ sender: Any) {
        changeRideTo(state: "end_trip")
               
    }
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func changeRideTo(state: String){
        showLoading(load: true)
          DispatchQueue.main.asyncAfter(deadline: .now() + 5){

            self.requestContainer.isHidden = false
            self.showLoading(load: false)
            self.changeStateTo(state: state)
            
        }
    }
    private func changeStateTo(state: String){
        
        accept.isHidden = true
        reject.isHidden = true
        iHaveArrived.isHidden = true
        endTrip.isHidden = true
        startTrip.isHidden = true
        
        switch(state){
        case "new_ride":
            accept.isHidden = false
            reject.isHidden = false
            break;
        case "i_have_arrived":
            contact(hide: false)
            iHaveArrived.isHidden = false
            break;
        case "start_trip":
            contact(hide: true)
            startTrip.isHidden = false
            break;
        case "end_trip":
            endTrip.isHidden = false
            break;
        default:
            break;
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
    
    func showLoading(load:Bool) -> Void {
        if load{
            self.view.makeToastActivity(.center)}
        else{
            self.view.hideToastActivity()
        }
    }
    
    @objc func animatePolylinePath() {
        if (self.i < self.path.count()) {
            self.animationPath.add(self.path.coordinate(at: self.i))
            self.animationPolyline.path = self.animationPath
            self.animationPolyline.strokeColor = UIColor.black
            self.animationPolyline.strokeWidth = 3
            self.animationPolyline.map = self.requestMap
            self.i += 1
        }
        else {
            self.i = 0
            self.animationPath = GMSMutablePath()
            self.animationPolyline.map = nil
        }
    }
    func drawRoute(routeDict: Dictionary<String, Any>) {

        let routesArray = routeDict ["routes"] as! NSArray

        if (routesArray.count > 0)
        {
            let routeDict = routesArray[0] as! Dictionary<String, Any>
            let routeOverviewPolyline = routeDict["overview_polyline"] as! Dictionary<String, Any>
            let points = routeOverviewPolyline["points"]
            self.path = GMSPath.init(fromEncodedPath: points as! String)!

            self.polyline.path = path
            self.polyline.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.polyline.strokeWidth = 3.0
            self.polyline.map = self.requestMap

            self.timer = Timer.scheduledTimer(timeInterval: 0.003, target: self, selector: #selector(animatePolylinePath), userInfo: nil, repeats: true)
        }
    }
}
extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
