//
//  Request.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 18/01/2021.
//  Copyright © 2021 Garihub Developers. All rights reserved.
//

import UIKit

class Request {
    //MARK: Properties
    
    var id: String
    var mobile: String
    var name: String
    var pickup: String
    var destination: String
    var rating: String
    var profilePicturePath: String
    var status: String
    var pickupLatLong: String
    var destinationLatLong: String

    
    
    init?(id: String, mobile: String, name: String, pickup: String, destination: String, rating: String, profilePicturePath: String, status: String, pickupLatLong: String, destinationLatLong: String) {
        self.id=id
        self.mobile=mobile
        self.name=name
        self.pickup=pickup
        self.destination=destination
        self.rating=rating
        self.profilePicturePath=profilePicturePath
        self.status=status
        self.pickupLatLong=pickupLatLong
        self.destinationLatLong=destinationLatLong
    }
}
