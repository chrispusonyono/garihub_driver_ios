//
//  Profile.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 08/02/2021.
//  Copyright © 2021 Garihub Developers. All rights reserved.
//

import UIKit
class Profile {
    //MARK: Properties
    
    var id: String
    var token: String
    var mobile: String
    var name: String
    var rating: String
    var profilePicturePath: String
    var email :String
    var status: Bool

    
    
    init?(id: String, token: String, mobile: String, name: String, rating: String, profilePicturePath: String,email: String, status: Bool) {
        self.id=id
        self.token=token
        self.mobile=mobile
        self.name=name
        self.rating=rating
        self.profilePicturePath=profilePicturePath
        self.email=email
        self.status=status
    }
}
