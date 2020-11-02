//
//  RegistrationTwoController.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 30/10/2020.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit

class RegistrationTwoController: BaseTextFieldController {
    
    var viewModel: RegistrationViewModel?
    var genderStatus = "MALE"
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var selectGender: UISegmentedControl!
    @IBOutlet weak var noGender: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.addTarget(self, action: #selector(self.onTap(_:)), for: .touchUpInside)
        setTransparentNavigationBar()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.goToLogin(_:)))
        loginView.addGestureRecognizer(tap)
        loginView.isUserInteractionEnabled = true
    }
    
    @objc func goToLogin(_ sender: UITapGestureRecognizer) {
        self.viewModel?.router.trigger(.login)
    }
    
    
    @IBAction func selectGender(_ sender: Any) {
        switch selectGender.selectedSegmentIndex {
        case 0:
            genderStatus = "MALE"
        case 1:
            genderStatus = "FEMALE"
        default:
            break
            
        }
    }
    
    @objc func onTap(_ sender: UIButton) {
        if fullNameTextField.text == "" {
            self.showAlert(withTitle: "Full Name", withMessage: "Your Full Names cannot be blank")
        }
        else {
            guard let vm = self.viewModel else { return }
            guard let fullNames = fullNameTextField.text else { return }
            vm.router.trigger(.emailRegister(fullName: fullNames, gender: genderStatus))
        }
        
        
    }
    
    
}
