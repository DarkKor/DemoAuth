//
//  AuthPresenter.swift
//  DemoAuth
//
//  Created by Dmitriy on 07.07.17.
//  Copyright © 2017 GrowApp Solutions. All rights reserved.
//

import Foundation

class AuthPresenter {
    public private(set) var authView: AuthViewProtocol?
    public private(set) var authService: AuthServiceProtocol?
    
    init(view: AuthViewProtocol, service: AuthServiceProtocol) {
        authView = view
        authService = service
    }
    
    func auth(login: String?, password: String?) {
        guard let login = login else {
            authView?.showEmptyEmailAlert()
            return
        }
        
        guard let password = password else {
            authView?.showWrongPasswordAlert()
            return
        }
        
        guard checkEmail(email: login) else {
            authView?.showWrongEmailAlert()
            return
        }
        
        guard checkPassword(password: password) else {
            authView?.showWrongPasswordAlert()
            return
        }
        
        authView?.startLoading()
        
        authService?.auth(login: login,
                          password: password,
                          failure: { [weak self] (error) in
                            self?.authView?.stopLoading()
                            self?.authView?.showError(error)
        },
                          completion: { [weak self] (result) in
                            self?.authView?.stopLoading()
                            self?.authView?.didLoggedIn()
        })
    }
    
    func authorized() {
        print("done")
        
        //  TODO: Demonstrate open Weather API
        WeatherAPI.shared.getWeather { [weak self] (json) in
            if let json = json {
                self?.authView?.showWeatherMessage(json)
            }
        }
    }
}

private extension AuthPresenter {
    func checkEmail(email: String) -> Bool {
        return email.isValidAsEmail
    }
    
    func checkPassword(password: String) -> Bool {
        return password.containsNumber &&
            password.containsLowercaseLetter &&
            password.containsUppercaseLetter
    }
}
