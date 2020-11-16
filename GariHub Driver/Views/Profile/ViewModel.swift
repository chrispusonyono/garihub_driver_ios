//
//  ViewModel.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 15/11/2020.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation
import XCoordinator
class ViewModel{
        //MARK: Properties

        let router: StrongRouter<OnboardingRoutes>
        var fullName: String
        var mobile: String
        var email: String
        
        
        
        init(fullName: String, mobile: String, email: String, router: StrongRouter<OnboardingRoutes>) {
        
            self.fullName=fullName
            self.mobile=mobile
            self.email=email
            self.router=router
        }
        
    }
