//
//  MainController.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 15/11/2020.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit
import ImageLoader
import Toast_Swift
import PopupDialog

class MainController: UIViewController {
    
    var viewModel: ViewModel?
    var shown = true
    var online = false
    @IBOutlet weak var stateColor: UIView!
    @IBOutlet weak var displayColor: UIView!
    @IBOutlet weak var displayText: UILabel!
    @IBOutlet weak var toggleText: UILabel!
    @IBOutlet weak var stateBar: UIView!
    @IBOutlet weak var dropDownToggle: UIImageView!
    @IBOutlet weak var profileTxt: UILabel!
    @IBOutlet weak var tripsTxt: UILabel!
    @IBOutlet weak var settingsTxt: UILabel!
    @IBOutlet weak var earningsTxt: UILabel!
    @IBOutlet weak var helpTxt: UILabel!
    @IBOutlet weak var summaryTxt: UILabel!
    @IBOutlet weak var logoutTxt: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var closeNavigationMenu: UIImageView!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var menus: UIView!
//    var viewModel: ViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        initialize()
    }

    private func initialize(){
        //closeNavigationMenu.addTarget(self, action: #selector(self.onTap(_:)), for: .touchUpInside)
        let dashboard = UITapGestureRecognizer(target: self, action: #selector(self.goToDashboard(_:)))
        let login = UITapGestureRecognizer(target: self, action: #selector(self.goToLogin(_:)))
        let notAvailable = UITapGestureRecognizer(target: self, action: #selector(self.unAvailable(_:)))
        let editUserProfile = UITapGestureRecognizer(target: self, action: #selector(self.editProfileIcon(_:)))
        let showHide = UITapGestureRecognizer(target: self, action: #selector(self.dropDownFunc(_:)))
        let goOnlineOffline = UITapGestureRecognizer(target: self, action: #selector(self.changeDriverState(_:)))
        
        closeNavigationMenu.addGestureRecognizer(dashboard)
        closeNavigationMenu.isUserInteractionEnabled = true
        
        profileTxt.addGestureRecognizer(notAvailable)
        profileTxt.isUserInteractionEnabled = true
        
        tripsTxt.addGestureRecognizer(notAvailable)
        tripsTxt.isUserInteractionEnabled = true
        
        settingsTxt.addGestureRecognizer(notAvailable)
        settingsTxt.isUserInteractionEnabled = true
        
        earningsTxt.addGestureRecognizer(notAvailable)
        earningsTxt.isUserInteractionEnabled = true
        
        helpTxt.addGestureRecognizer(notAvailable)
        helpTxt.isUserInteractionEnabled = true
        
        summaryTxt.addGestureRecognizer(notAvailable)
        summaryTxt.isUserInteractionEnabled = true
        
        logoutTxt.addGestureRecognizer(login)
        logoutTxt.isUserInteractionEnabled = true
        
        dropDownToggle.addGestureRecognizer(showHide)
        dropDownToggle.isUserInteractionEnabled = true
        
        toggleText.addGestureRecognizer(goOnlineOffline)
        toggleText.isUserInteractionEnabled = true
        
        profileImage.addGestureRecognizer(editUserProfile)
        profileImage.isUserInteractionEnabled = true
        
        email.text = viewModel?.email
        number.text = viewModel?.mobile
        fullName.text = viewModel?.fullName
        profileImage.load.request(with: "https://scontent.fnbo9-1.fna.fbcdn.net/v/t1.0-1/p160x160/74585102_2675809565774216_3866378604090753024_n.jpg?_nc_cat=104&ccb=2&_nc_sid=dbb9e7&_nc_ohc=Rtm77jSJMekAX_ejMyQ&_nc_pt=5&_nc_ht=scontent.fnbo9-1.fna&tp=6&oh=844ed40f163d29e162aae14f46791163&oe=5FD8ACDD")
    }
    
    
    
    @objc func goToDashboard(_ sender: UITapGestureRecognizer) {
           self.viewModel?.router.trigger(.dashboard)
       }
    @objc func editProfileIcon(_ sender: UITapGestureRecognizer) {
              editProfile()
          }
    
    @objc func dropDownFunc(_ sender: UITapGestureRecognizer) {
           if(self.shown) {
               self.stateBar.frame.size.height = 0
           }else{
               self.stateBar.frame.size.height = 50
           }
           self.shown = !self.shown
        
       }
    
    @objc func goToLogin(_ sender: UITapGestureRecognizer) {
        self.viewModel?.router.trigger(.login)
    }
    
    func showLoading(load:Bool) -> Void {
        if load{
            self.view.makeToastActivity(.center)}
        else{
            self.view.hideToastActivity()
        }
    }
    private func editProfile() {
        let profileEdit = ProfileChangeViewController(nibName: "ProfileChangeViewController", bundle: nil)
        
    
        
        
        let popup = PopupDialog(viewController: profileEdit,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                preferredWidth: 580,
                                tapGestureDismissal: false,
                                panGestureDismissal: false,
                                hideStatusBar: true,
                                completion:  nil)
        
        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
        }
        let buttonTwo = DefaultButton(title: "SAVE", height: 60) {
           // self.fullName.text = profileEdit.fullName.text
           // self.profileImage.image = profileEdit.profilePicture.image
           // self.view.makeToastActivity(.center)
//            let parameters = [
//                "action": "changeProfile",
//                "token": UserDefaults.standard.string(forKey: "token") ?? "",
//                "fullName": self.fullName.text ?? ""
//            ]
//            Alamofire.upload(multipartFormData: { multipartFormData in
//                
//                multipartFormData.append(self.profilePicture.image!.jpegData(compressionQuality: 0.75)!, withName: "icon",fileName: "file.jpg", mimeType: "image/jpg")
//                
//                for (key, value) in parameters {
//                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                }
//            },
//                             to:Constant.URLS.PROJECT)
//            { (result) in
//                
//                switch result {
//                case .success(let upload, _, _):
//                    
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                    })
//                    
//                    upload.responseJSON { response in
//                        self.view.hideToastActivity()
//                        print(response)
//                        let dataIn = response.result.value as! NSDictionary
//                        if((dataIn.value(forKey: "status") as! Bool)){
//                            print(dataIn)
//                            let profileData = dataIn.value(forKey: "profile") as! NSDictionary
//                            let token = profileData.value(forKey: "token") as! String
//                            let fullName = profileData.value(forKey: "fullName") as! String
//                            let email = profileData.value(forKey: "email") as! String
//                            let profilePicture = profileData.value(forKey: "profilePicture") as! String
//                            let profile = Profile(loggedIn: true, token: token, fullName: fullName, email: email, profilePicture: profilePicture)
//                            Constant.FUNCTIONS.setUserProfile(profile: profile)
//                            self.view.makeToast("Profile Updated successfully")
//                            
//                        }else{
//                            self.fullName.text=self.session.string(forKey: "fullName")
//                            self.profilePicture.load.request(with: self.session.string(forKey: "profilePicture") ?? "")
//                            let alert = UIAlertController(title: "Error", message: dataIn.value(forKey: "message") as? String, preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//                            self.present(alert, animated: true, completion: nil)
//                        }
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//            }
            
            
            
        }
        
        popup.addButtons([buttonOne, buttonTwo])
        self.present(popup, animated: true, completion: nil)
    }
    @objc func changeDriverState(_ sender: UITapGestureRecognizer){
        showLoading(load: true)
        stateTo(online: online)
    }
    @objc func unAvailable(_ sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "Info", message: "The page is not available", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    private func setUpUI(){

        menus.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        menus.clipsToBounds = true

        profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        profileImage.layer.borderWidth = 2.0;
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        profileImage.layer.masksToBounds = true;
        info.attributedText = highLight(with: "www.garihub.com", targetString: "For more information, visit:www.garihub.com")
        mobile.attributedText = highLight(with: "0700000000", targetString: "Or call our 24/7 Customer Care 0700000000")
    }
    
    func stateTo(online: Bool){
        if(online){
            displayText.text = "Currently Offline"
            toggleText.text = "Online"
            stateColor.backgroundColor = UIColor.systemYellow
            displayColor.backgroundColor = UIColor.systemGray
        }else{
            displayText.text = "Currently Online"
            toggleText.text = "Offline"
            stateColor.backgroundColor = UIColor.systemGray
            displayColor.backgroundColor = UIColor.systemYellow
        }
    }
    func highLight(with searchTerm: String, targetString: String) -> NSAttributedString? {

        let attributedString = NSMutableAttributedString(string: targetString)
        do {
            let regex = try NSRegularExpression(pattern: searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .diacriticInsensitive, locale: .current), options: .caseInsensitive)
            let range = NSRange(location: 0, length: targetString.utf16.count)
            for match in regex.matches(in: targetString.folding(options: .diacriticInsensitive, locale: .current), options: .withTransparentBounds, range: range) {
                //attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold), range: match.range)
                attributedString.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.systemYellow, range: match.range)
            }
            return attributedString
        } catch {
            NSLog("Error creating regular expresion: \(error)")
            return nil
        }
    }
    override func viewWillAppear(_ animated: Bool){
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
       
       }
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(false, animated: animated)
       }
}
extension UIView{
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

        enum Visibility {
            case visible
            case invisible
            case gone
        }

        var visibility: Visibility {
            get {
                let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
                if let constraint = constraint, constraint.isActive {
                    return .gone
                } else {
                    return self.isHidden ? .invisible : .visible
                }
            }
            set {
                if self.visibility != newValue {
                    self.setVisibility(newValue)
                }
            }
        }

        private func setVisibility(_ visibility: Visibility) {
            let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)

            switch visibility {
            case .visible:
                constraint?.isActive = false
                self.isHidden = false
                break
            case .invisible:
                constraint?.isActive = false
                self.isHidden = true
                break
            case .gone:
                if let constraint = constraint {
                    constraint.isActive = true
                } else {
                    let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
                    self.addConstraint(constraint)
                    constraint.isActive = true
                }
            }
        }
   
    
}
