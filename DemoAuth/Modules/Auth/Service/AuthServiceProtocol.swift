//
//  AuthServiceProtocol.swift
//  DemoAuth
//
//  Created by Dmitriy on 07.07.17.
//  Copyright © 2017 GrowApp Solutions. All rights reserved.
//

import Foundation

protocol AuthServiceProtocol {
    func auth(login: String,
              password: String,
              failure: @escaping (Error) -> (),
              completion: @escaping (AuthServiceResultProtocol) -> ())
}

