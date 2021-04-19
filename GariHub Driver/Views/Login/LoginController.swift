//
//  LoginController.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 19/10/2020.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
import SwiftyJSON
class LoginController: UIViewController {
    
    
    @IBOutlet weak var splash: UIView!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var forgotPassword: UILabel!
    var retries = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let resertPassAction = UITapGestureRecognizer(target: self, action: #selector(self.resetPassword(_:)))
        forgotPassword.addGestureRecognizer(resertPassAction)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5){

            self.goHome()
            
        }
      
    }
    
    
    
    @IBAction func loginClicked(_ sender: UIButton) ->Void{
        startLogin()
    }
    private func startLogin(){
        let username = emailAddress.text ?? ""
        let password = self.password.text ?? ""
        
        if username.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Username can not be blank", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if password.isEmpty  {
            let alert = UIAlertController(title: "Error", message: "Password can not be blank", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        showLoading(load: true)
        
        
        let parameters: Parameters=[
            "client_id":"mobile-client",
            "grant_type":"password",
            "device": "IOS",
            "token":UserDefaults(suiteName:"app")!.string(forKey: "deviceToken") ?? "0",
            "username":username,
            "password":password
        ]
        Alamofire.request("\(Constant.URLS.SERVER)/auth/realms/garihub-driver/protocol/openid-connect/token", method: .post, parameters: parameters).validate().responseJSON {
            response in
            self.showLoading(load: false)
            switch response.result {
            case .success:
                
                  let dataIn = response.result.value as! NSDictionary
                    if((dataIn.value(forKey: "token_type") as! String) == "bearer"){
                        
                        let profile = Profile(id: "1", token: "", mobile: "", name: "", rating: "0.0", profilePicturePath: "",email: username, status: false)
                        Constant.setUserProfile(profile: profile!)
                        Constant.justLoggedIn = true
                        self.fetchProfile(token: dataIn.value(forKey: "access_token") as! String)
                    }else{

                        let alert = UIAlertController(title: "Error", message: dataIn.value(forKey: "error_description") as? String, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                
            case .failure(let error):

                if(response.response?.statusCode==401){
                     let dataIn = JSON(response.data!)
                
                    let alert = UIAlertController(title: "Error", message: dataIn["error_description"].stringValue, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                let alert = UIAlertController(title: "Error", message: "Unable to reach server: \(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
                    print(error)
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if (Constant.loggedOut) {
            self.goHome()
            Constant.loggedOut=false
            
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
   @objc func resetPassword(_ sender: UITapGestureRecognizer) {
//    let popup = ProfileChangeViewController(nibName: "ProfileChangeViewController", bundle: nil)
//    self.addChild(popup)
//        popup.view.frame = self.view.frame
//        self.view.addSubview(popup.view)
//    popup.didMove(toParent: self)
    
    let popup = ResetController(nibName: "ResetController", bundle: nil)
    self.addChild(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
    popup.didMove(toParent: self)
   
    }
    private func showLoading(load:Bool) -> Void {
        if load{
            self.view.makeToastActivity(.center)}
        else{
            self.view.hideToastActivity()
        }
    }
    private func goHome() ->Void{
        
//        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
//        let login = storyboard.instantiateViewController(withIdentifier: "Homepage") as! DashboardController
//        self.present(login, animated:true, completion:nil)
        if((Constant.getUserProfile().token != "") && Constant.getUserProfile().mobile != ""){
            let vc = DashboardController(nibName: "DashboardController", bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }else{
            splash.isHidden = true
        }
        
        //self.navigationController!.pushViewController(vc, animated: true)
    }
    private func fetchProfile(token : String){
        splash.isHidden = false
        showLoading(load: true)
        let profile = Constant.getUserProfile()
        
        let headers: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        Alamofire.request("\(Constant.URLS.PROJECT)driver-profile-service/v1/", method: .get, headers: headers).validate().responseJSON {
            response in
            self.showLoading(load: false)
            switch response.result {
            case .success:
                
                let sp = JSON(response.result.value as Any)
                  var icon : String
                  if(sp["profile_pic_url"].stringValue == ""){
                      icon = Constant.ICON
                  }
                  else {
                    icon = sp["profile_pic_url"].stringValue
                  }
                  profile.email = sp["email_address"].stringValue
                  profile.mobile = sp["phone_number"].stringValue
                  profile.profilePicturePath = icon
                  profile.name = sp["first_name"].stringValue
                  profile.token = token
                  profile.status = false
                  Constant.setUserProfile(profile: profile)
                  self.goHome()
            case .failure(let error):

                let alert = UIAlertController(title: "Error", message: error.localizedDescription + token, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction!) in
                    if(self.retries == 10){
                        self.startLogin()
                    }else if(self.retries == 15){
                        self.splash.isHidden = true
                        self.retries = 0
                    }else{
                       self.fetchProfile(token: token)
                    }
                    self.retries = self.retries + 1
                    
                }))
               self.present(alert, animated: true, completion: nil)
                    print(error)
                
            }
        }
        
        
    }
}
