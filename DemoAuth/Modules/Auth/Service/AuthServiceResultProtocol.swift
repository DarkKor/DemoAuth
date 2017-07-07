//
//  AuthServiceResultProtocol.swift
//  DemoAuth
//
//  Created by Dmitriy on 07.07.17.
//  Copyright © 2017 GrowApp Solutions. All rights reserved.
//

import UIKit

protocol AuthServiceResultProtocol {
    var id: Int? { get set }
    var token: String? { get set }
    var firstName: String? { get set }
    var lastName: String? { get set }
}
