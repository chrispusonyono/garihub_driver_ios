//
//  BaseAuthModel.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation
import Moya


class BaseAuthModel {
    let authPlugin: AccessTokenPlugin
    let client: GariHubDriverClient
    let provider: MoyaProvider<AuthTarget>
    
    init(client: GariHubDriverClient) {
        self.authPlugin = AccessTokenPlugin { _ in client.token }
        self.client = client
        self.provider = MoyaProvider<AuthTarget>(plugins: [authPlugin, NetworkLoggerPlugin()])
    }
}
