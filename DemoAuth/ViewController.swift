//
//  ViewController.swift
//  DemoAuth
//
//  Created by Dmitriy on 07.07.17.
//  Copyright © 2017 GrowApp Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonAuthTouched(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AuthViewControllerID")
        let authController = controller as! AuthViewController
        
        authController.presenter = AuthPresenter(view: authController,
                                                 service: MockAuthService())
        
        self.navigationController?.pushViewController(authController, animated: true)
    }
}

