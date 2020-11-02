//
//  GariHubDriverClient.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation
import Moya
import SwiftKeychainWrapper


class GariHubDriverClient {
    static let shared: KeychainWrapper = KeychainWrapper.standard
    
    var isLoggedIn: Bool {
        if savedToken == "" || savedToken == nil {
            return false
        }
        return true
    }

    
    private var savedToken: String? {
        return GariHubDriverClient.shared.string(forKey: "token")
    }
    
    
    var token: String {
        get {
            return self.savedToken ?? ""
        }
        set {
            GariHubDriverClient.shared.set(newValue, forKey: "token")
        }
    }

    
    func logout() {
        GariHubDriverClient.shared.removeAllKeys()
    }
}
