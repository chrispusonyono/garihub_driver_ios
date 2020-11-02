//
//  EmailRegViewModel.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation
import XCoordinator

class EmailRegViewModel: BaseAuthModel {
    
    let router: StrongRouter<OnboardingRoutes>
    let fullName: String
    let gender: String
    

    init(client: GariHubDriverClient, router: StrongRouter<OnboardingRoutes>, fullName: String, gender: String) {
        self.fullName = fullName
        self.gender = gender
        self.router = router
        super.init(client: client)
    }
    
}
