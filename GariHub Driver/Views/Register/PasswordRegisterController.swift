//
//  PasswordRegisterController.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 30/10/2020.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit

class PasswordRegisterController: UIViewController {
    
    var viewModel: PasswordRegViewModel?
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.addTarget(self, action: #selector(self.onTap(_:)), for: .touchUpInside)
    }
    

    @objc func onTap(_ sender: UIButton) {
        
        if password.text == "" || confirmPassword.text == "" {
            self.showAlert(withTitle: "Password", withMessage: "Password fields cannot be blank")
        }
        else {
            guard let vm = self.viewModel else { return }
                self.showSpinner(onView: self.view)
                
                guard let password = password.text else { return }
                
                let request = RegisterRequest(firstName: vm.fullName, lastName: vm.fullName, gender: vm.gender, phoneNumber: "", emailAddress: vm.emailAddress, userType: "DRIVER", password: password)
                
                vm.provider.request(.register(request: request)) {
                    result in
                    self.removeSpinner()
                    
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let response):
                        do {
                            _ = try JSONDecoder().decode(RegisterResponse.self, from: response.data)
                            self.viewModel?.router.trigger(.login)
                            DispatchQueue.main.async {
                                self.showAlert(withTitle: "Success", withMessage: "Registration was Successful")
                            }
                        }
                        catch {
                            DispatchQueue.main.async {
                               let alertController = UIAlertController(title: "Error", message: "Registration failed, please try again later", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                                })
                                alertController.addAction(defaultAction)
                                self.present(alertController, animated: true)
                            }
                        }
                    }
                }
            }
        }
        
}
