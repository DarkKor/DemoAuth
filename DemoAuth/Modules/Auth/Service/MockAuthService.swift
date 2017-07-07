//
//  MockAuthService.swift
//  DemoAuth
//
//  Created by Dmitriy on 07.07.17.
//  Copyright © 2017 GrowApp Solutions. All rights reserved.
//

import Foundation

class MockAuthService: AuthServiceProtocol {
    func auth(login: String,
              password: String,
              failure: @escaping (Error) -> (),
              completion: @escaping (AuthServiceResultProtocol) -> ()) {
        DispatchQueue.main.after(0.5) { 
            let result = MockAuthServiceResult()
            result.id = 1
            result.firstName = "Jonh"
            result.lastName = "Doe"
            result.token = "sdlfjposdf3su12dfshioho"
            
            completion(result)
        }
    }
}
