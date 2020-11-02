//
//  LoginController.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 19/10/2020.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    var viewModel: LoginViewModel?
    
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signInBtn.addTarget(self, action: #selector(self.onTap(_:)), for: .touchUpInside)
    }
    
    @objc func onTap(_ sender: UIButton) {
        //        loginUser()
        self.showSpinner(onView: self.view)
        
        guard let email = emailAddress.text else { return }
        guard let password = password.text else { return }
        guard let vm = self.viewModel else { return }
        
        let request = LoginRequest(emailAddress: email, password: password)
        
        vm.provider.request(.login(request: request)) {
            result in
            self.removeSpinner()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                    self.viewModel?.router.trigger(.dashboard)
                    print(loginResponse)
                    DispatchQueue.main.async {
                        self.showAlert(withTitle: "Success", withMessage: "Login was successful")
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Error", message: "Login failed", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
        
        
    }
    
    func loginUser() {
        if emailAddress.text == "" || password.text == "" {
            self.showAlert(withTitle: "Empty", withMessage: "Email and password fields cannot be empty")
        }
        else {
            self.showSpinner(onView: self.view)
            guard let email = emailAddress.text else { return }
            guard let password = password.text else { return }
            
            let requestHeaders: [String: String] = [
                "Content-Type": "application/json"
            ]
            var requestBodyComponents = URLComponents()
            requestBodyComponents.queryItems = [
                URLQueryItem(name: "client_id", value: "mobile-client"),
                URLQueryItem(name: "grant_type", value: "password"),
                URLQueryItem(name: "username", value: email),
                URLQueryItem(name: "password", value: password)
            ]
            
            // MARK: Request configuration
            
            var request = URLRequest(url: URL(string: "http://68.183.242.242/api/driver-service/v1/driver/login")!)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = requestHeaders
            request.httpBody = requestBodyComponents.query?.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                self.removeSpinner()
                
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data!)
                    print(loginResponse)
                    DispatchQueue.main.async {
                        self.showAlert(withTitle: "Success", withMessage: "Login was successful")
                    }
                    
                    
                } catch {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Invalid credentials", message: "Kind enter valid username and password", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
            }.resume()
        }
        
        
        
    }
    
    
}
