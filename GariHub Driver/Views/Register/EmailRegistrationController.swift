//
//  EmailRegistrationController.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 30/10/2020.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit

class EmailRegistrationController: UIViewController {
    
    var viewModel: EmailRegViewModel?
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.addTarget(self, action: #selector(self.onTap(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func onTap(_ sender: UIButton) {
        if emailAddress.text == "" {
            self.showAlert(withTitle: "Email Address", withMessage: "Email address cannot be blank")
        }
        else {
            guard let vm = self.viewModel else { return }
            guard let email = emailAddress.text else { return }
            vm.router.trigger(.passwordRegister(fullName: vm.fullName, gender: vm.gender, email: email))
        }
        
    }
    
}
