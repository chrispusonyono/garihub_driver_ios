//
//  MainController.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 15/11/2020.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit
import ImageLoader

class MainController: UIViewController {
    
    var viewModel: ViewModel?
    
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
        let Profile = UITapGestureRecognizer(target: self, action: #selector(self.unAvailable(_:)))
        
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
        
        email.text = viewModel?.email
        number.text = viewModel?.mobile
        fullName.text = viewModel?.fullName
        profileImage.load.request(with: "https://scontent.fnbo9-1.fna.fbcdn.net/v/t1.0-1/p160x160/74585102_2675809565774216_3866378604090753024_n.jpg?_nc_cat=104&ccb=2&_nc_sid=dbb9e7&_nc_ohc=Rtm77jSJMekAX_ejMyQ&_nc_pt=5&_nc_ht=scontent.fnbo9-1.fna&tp=6&oh=844ed40f163d29e162aae14f46791163&oe=5FD8ACDD")
    }
    
    
    
    @objc func goToDashboard(_ sender: UITapGestureRecognizer) {
        self.viewModel?.router.trigger(.dashboard)
    }
    @objc func goToLogin(_ sender: UITapGestureRecognizer) {
        self.viewModel?.router.trigger(.login)
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

}
extension UIView{
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
