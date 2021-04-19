//
//  AuthTarget.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation

enum AuthTarget {
    
    case register(request: RegisterRequest)
    case login(request: LoginRequest)
    
}

