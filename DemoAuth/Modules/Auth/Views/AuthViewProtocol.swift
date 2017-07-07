//
//  AuthViewProtocol.swift
//  DemoAuth
//
//  Created by Dmitriy on 07.07.17.
//  Copyright © 2017 GrowApp Solutions. All rights reserved.
//

import UIKit

protocol AuthViewProtocol {
    func startLoading()
    func stopLoading()
    
    func didLoggedIn()
    func restorePassword()
    
    func showEmptyEmailAlert()
    func showWrongEmailAlert()
    func showWrongPasswordAlert()
    func showError(_ error: Error)
    
    func showWeatherMessage(_ weather: [String : Any])
}
