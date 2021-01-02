//
//  RiderRequestController.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 07/12/2020.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit
import ImageLoader

class RiderRequestController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var reject: UIButton!
    @IBOutlet weak var iHaveArrived: UIButton!
    @IBOutlet weak var endTrip: UIButton!
    @IBOutlet weak var startTrip: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }

    private func initialize(){
        changeStateTo(state: "new_ride")
        profileImage.load.request(with: "https://scontent.fnbo9-1.fna.fbcdn.net/v/t1.0-1/p160x160/74585102_2675809565774216_3866378604090753024_n.jpg?_nc_cat=104&ccb=2&_nc_sid=dbb9e7&_nc_ohc=Rtm77jSJMekAX_ejMyQ&_nc_pt=5&_nc_ht=scontent.fnbo9-1.fna&tp=6&oh=844ed40f163d29e162aae14f46791163&oe=5FD8ACDD")
        
    }

    @IBAction func acceptRideFromRider(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.changeStateTo(state: "i_have_arrived")
        }
    }
    @IBAction func ihaveArrived(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.changeStateTo(state: "start_trip")
               }
    }
    @IBAction func swipeToStart(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.changeStateTo(state: "end_trip")
               }
    }
    @IBAction func swipeToEnd(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                   //changeStateTo(state: "end_trip")
               }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
            iHaveArrived.isHidden = false
            break;
        case "end_trip":
            endTrip.isHidden = false
            break;
        case "start_trip":
            startTrip.isHidden = false
            break;
        default:
            break;
            
        }
    }

}
