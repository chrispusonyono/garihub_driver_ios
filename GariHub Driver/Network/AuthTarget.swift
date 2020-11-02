//
//  AuthTarget.swift
//  GariHub Driver
//
//  Created by Kevin Lagat on 11/2/20.
//  Copyright © 2020 Kevin Lagat. All rights reserved.
//

import Foundation
import Moya

enum AuthTarget {
    
    case register(request: RegisterRequest)
    case login(request: LoginRequest)
    
}

extension AuthTarget: TargetType {
    
    var baseURL: URL { return URL (string: "http://68.183.242.242/")! }

    
    var path: String {
        switch self {
        case .register:
            return "api/driver-service/v1/driver/register"
        case .login:
            return "api/driver-service/v1/driver/login"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .register(let request):
            return [
                "firstName": request.firstName,
                "lastName": request.lastName,
                "gender": request.gender,
                "phoneNumber": request.phoneNumber,
                "emailAddress": request.emailAddress,
                "userType": request.userType,
                "password": request.password
            ]
        case .login(let request):
            return [
                "emailAddress": request.emailAddress,
                "password": request.password
            ]
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: JSONEncoding.default)
        }
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
        ]
    }
    
}
