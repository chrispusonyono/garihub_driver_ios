//
//  Constant.swift
//  GariHub Driver
//
//  Created by Chrispus Onyono on 18/01/2021.
//  Copyright © 2021 Garihub Developers. All rights reserved.
//

import Foundation
import Starscream
class Constant {
    static let GoogleMapApiKey = "AIzaSyDy4XgOiSH1w6F6Nt92CvU3cRjYtWiJjT4"
    static let ICON = "https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg"
    static let WebSocketURL = "ws://dev.garihub.com/api/socket-service"
    static var justLoggedIn = false
    static var socket : WebSocket?
    static var isConnected = false
    static var loggedOut = false
    static var dashboard : DashboardController?
    struct URLS {
        static let SERVER = "http://dev.garihub.com"
        static let PROJECT = SERVER+"/api/"
        
    }
    struct DATA {
        static var session = UserDefaults.standard
        static var REQUEST : Request?
        static var profile : Profile?
    }
    static func setUserProfile(profile : Profile) -> Void {
        Constant.DATA.session.set(profile.id, forKey: "id")
        Constant.DATA.session.set(profile.token, forKey: "token")
        Constant.DATA.session.set(profile.mobile, forKey: "mobile")
        Constant.DATA.session.set(profile.name, forKey: "name")
        Constant.DATA.session.set(profile.rating, forKey: "rating")
        Constant.DATA.session.set(profile.profilePicturePath, forKey: "profilePicturePath")
        Constant.DATA.session.set(profile.email, forKey: "email")
        Constant.DATA.session.set("0", forKey: "status")
    }
    static func getUserProfile()-> Profile{
        let store = Constant.DATA.session
        let profile = Profile(id: store.string(forKey: "id") ?? "", token: store.string(forKey: "token") ?? "", mobile: store.string(forKey: "mobile") ?? "", name: store.string(forKey: "name") ?? "", rating: store.string(forKey: "rating") ?? "", profilePicturePath: store.string(forKey: "profilePicturePath") ?? "", email: store.string(forKey: "email") ?? "", status: store.bool(forKey: "status"))
    
        return profile!
    }
}

