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

    @IBOutlet weak var requestHeightMultiplier: NSLayoutConstraint!
    @IBOutlet weak var contactHeight: NSLayoutConstraint!
    @IBOutlet weak var requestHolder: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var reject: UIButton!
    @IBOutlet weak var iHaveArrived: UIButton!
    @IBOutlet weak var endTrip: UIButton!
    @IBOutlet weak var startTrip: UIButton!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var call: UIButton!
    @IBOutlet weak var contactHolder: UIView!
    @IBOutlet weak var requestMap: GMSMapView!
    	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        initialize()
    }

    private func initialize(){
        changeRideTo(state: "new_ride")
        profileImage.load.request(with: "https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg")
        
    }
    private func contact(hide: Bool){
        let realWidth = requestHolder.frame.width
        let realHeight = realWidth * 1.2
        let itemheight = realHeight/3
        
        if (hide){
//            requestHolderRatio.constant = 1.2
            //.aspectRation(6.0/5.0).isActive = true
            contactHeight.constant =  0
            contactHolder.isHidden = true
        }else{
//            requestHolderRatio.constant = 1
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
          self.view.makeToastActivity(.center)
          DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.view.hideAllToasts()
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
        case "end_trip":
            endTrip.isHidden = false
            break;
        case "start_trip":
            contact(hide: true)
            startTrip.isHidden = false
            break;
        case "end_trip":
            
            break;
        default:
            break;
            
        }
    }

}
extension UIView {

    func aspectRation(_ ratio: CGFloat) -> NSLayoutConstraint {

        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
}
