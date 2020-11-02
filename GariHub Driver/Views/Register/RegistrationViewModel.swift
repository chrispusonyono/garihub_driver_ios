//
//  RegistrationViewModel.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation
import XCoordinator

class RegistrationViewModel: BaseAuthModel {
    
    let router: StrongRouter<OnboardingRoutes>

    init(client: GariHubDriverClient, router: StrongRouter<OnboardingRoutes>) {
        self.router = router
        super.init(client: client)
    }
    
}
