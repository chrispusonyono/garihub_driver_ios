//
//  OnboardingCoordinator.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation
import XCoordinator

enum OnboardingRoutes: Route {
    case dashboard
    case emailRegister(fullName: String, gender: String)
    case login
    case passwordRegister(fullName: String, gender: String, email: String)
    case register
    case profile(fullName:String, email:String, mobile:String)
}

class OnboardingCoordinator: NavigationCoordinator<OnboardingRoutes> {
    let client: GariHubDriverClient
    
    init() {
        self.client = GariHubDriverClient()
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.backgroundColor = .black
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.tintColor = .black
        
        super.init(rootViewController: navigationController, initialRoute: .login)
    }
    
    override func prepareTransition(for route: OnboardingRoutes) -> NavigationTransition {
        switch route {
        case .dashboard:
            let viewModel = DashboardViewModel(client: client, router: self.strongRouter)
            let dashboard = DashboardController()
            dashboard.viewModel = viewModel
            return .set([dashboard])
        case .emailRegister(let fullName, let gender):
            let viewModel = EmailRegViewModel(client: client, router: self.strongRouter, fullName: fullName, gender: gender)
            let emailRegVc = EmailRegistrationController()
            emailRegVc.viewModel = viewModel
            return .set([emailRegVc])
            
        case .passwordRegister(let fullName, let gender, let email):
            let viewModel = PasswordRegViewModel(client: client, router: self.strongRouter, fullName: fullName, gender: gender, emailAddress: email)
            let passwordVC = PasswordRegisterController()
            passwordVC.viewModel = viewModel
            return .set([passwordVC])
            
        case .register:
            let viewModel = RegistrationViewModel(client: client, router: self.strongRouter)
            let regTwoVC = RegistrationTwoController()
            regTwoVC.viewModel = viewModel
            return .set([regTwoVC])
            
        case .login:
            let viewModel = LoginViewModel(client: client, router: self.strongRouter)
            let loginVC = LoginController()
            loginVC.viewModel = viewModel
            return .set([loginVC])
        case .profile(let fullName, let email, let mobile):
            let viewModel = ViewModel(fullName: fullName, mobile: mobile, email: email, router: self.strongRouter)
            let profileCV = MainController()
            profileCV.viewModel = viewModel
            return .set([profileCV])
        }
    }
}
 
protocol AppCoordinatorDelegate {
    func selectRoute(_ route: OnboardingRoutes)
}

extension OnboardingCoordinator: AppCoordinatorDelegate {
    func selectRoute(_ route: OnboardingRoutes) {
        self.strongRouter.trigger(route)
    }
}

extension Transition {
    static func dismissAll() -> Transition {
        return Transition(presentables: [], animationInUse: nil) { rootViewController, options, completion in
            guard let presentedViewController = rootViewController.presentedViewController else {
                completion?()
                return
            }
            presentedViewController.dismiss(animated: options.animated) {
                Transition.dismissAll()
                    .perform(on: rootViewController, with: options, completion: completion)
            }
        }
    }
}
