//
//  BaseAuthModel.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation


class BaseAuthModel {
    let client: GariHubDriverClient
    
    init(client: GariHubDriverClient) {
        self.client = client
    }
}
