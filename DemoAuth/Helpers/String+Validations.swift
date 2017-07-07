//
//  String+Validations.swift
//  DemoAuth
//
//  Created by Dmitriy on 07.07.17.
//  Copyright © 2017 GrowApp Solutions. All rights reserved.
//

import Foundation

extension String {
    var isValidAsEmail: Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        let result = predicate.evaluate(with: self)
        print(result)
        return result
    }
    
    var containsLowercaseLetter: Bool {
        let regEx = ".*[a-z]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        let result = predicate.evaluate(with: self)
        print(result)
        return result
    }
    
    var containsUppercaseLetter: Bool {
        let regEx = ".*[A-Z]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        let result = predicate.evaluate(with: self)
        print(result)
        return result
    }
    
    var containsNumber: Bool {
        let regEx = ".*[0-9]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        let result = predicate.evaluate(with: self)
        print(result)
        return result
    }
}
