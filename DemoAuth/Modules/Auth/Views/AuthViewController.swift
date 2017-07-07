//
//  AuthViewController.swift
//  DemoAuth
//
//  Created by Dmitriy on 07.07.17.
//  Copyright © 2017 GrowApp Solutions. All rights reserved.
//

import UIKit

fileprivate let activeCursorColor = UIColor(hexString: "#4e92df")
fileprivate let inactiveCursorColor = UIColor(hexString: "#ebebeb")
fileprivate let activePlaceholderColor = UIColor(hexString: "#797979")
fileprivate let inactivePlaceholderColor = UIColor(hexString: "#333333")


class AuthViewController: UIViewController {

    var presenter: AuthPresenter!
    
    @IBOutlet weak var authView: UIView!
    
    @IBOutlet weak var txtLogin: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var loginSeparator: UIView!
    @IBOutlet weak var passwordSeparator: UIView!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgot: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        customize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObserves()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObserves()
    }
}

extension AuthViewController: AuthViewProtocol {
    func startLoading() {
        HUD.show(.progress)
    }
    
    func stopLoading() {
        HUD.hide()
    }
    
    func didLoggedIn() {
        HUD.flash(.success, onView: nil, delay: 0.5) { [weak self] (result) in
            self?.presenter.authorized()
        }
        
        view.endEditing(true)
    }
    
    func restorePassword() {
        
    }
    
    func showEmptyEmailAlert() {
        showAlert("Почта не должна быть пустой")
    }
    
    func showWrongEmailAlert() {
        showAlert("Некорректный адрес электронной почты")
    }
    
    func showWrongPasswordAlert() {
        showAlert("Пароль должен состоять как минимум из 6 символов и содержать хотя бы 1 заглавную, 1 прописную букву и 1 цифру")
    }
    
    func showError(_ error: Error) {
        showAlert(error.localizedDescription)
    }
    
    func showWeatherMessage(_ weather: [String : Any]) {
        print("\(weather)")
        
        var message = ""
        if let main = weather["main"] as? [String : Any] {
            message += main.description + "\n"
        }
        if let info = weather["weather"] as? [[String : Any]] {
            message += info.description
        }
        
        showAlert(message)
    }
}

//  MARK: - Actions
extension AuthViewController {
    @IBAction func btnForgotTouched(_ sender: UIButton) {
        
    }
    
    @IBAction func btnLoginTouched(_ sender: UIButton) {
        presenter.auth(login: txtLogin.text,
                       password: txtPassword.text)
    }
    
    @IBAction func btnBackTouched(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}

//  MARK: - Private Methods
private extension AuthViewController {
    func customize() {
        btnForgot.layer.cornerRadius = 6
        btnForgot.layer.masksToBounds = true
        btnForgot.layer.borderColor = inactiveCursorColor.cgColor
        btnForgot.layer.borderWidth = 0.5
        
        btnLogin.layer.cornerRadius = 22
        btnLogin.layer.masksToBounds = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_back"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(btnBackTouched(_:)))
        
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func addKeyboardObserves() {
        let notificationCenter = NotificationCenter.default
        
        
        notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillHide,
                                       object: nil,
                                       queue: nil) { [weak self] (notification) in
                                        guard let strongSelf = self else { return }
                                        strongSelf.centerAuthView(0)
        }
        
        notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillShow,
                                       object: nil,
                                       queue: nil) { [weak self] (notification) in
                                        guard let strongSelf = self else { return }
                                        if let v = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                                            let frame = v.cgRectValue
                                            let height = frame.height
                                            strongSelf.centerAuthView(height)
                                        }
        }
    }
    
    func removeKeyboardObserves() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func centerAuthView(_ keyboardHeight: CGFloat) {
        let wholeHeight = view.height
        let centeredHeight = wholeHeight - keyboardHeight
        let authViewTop = (centeredHeight - authView.height) / 2.0
        UIView.animateKeyframes(withDuration: 0.2,
                                delay: 0.0,
                                options: .calculationModeCubicPaced,
                                animations: { 
                                    self.authView.top = authViewTop
        },
                                completion: nil)
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

//  MARK: - UITextFieldDelegate Methods
extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as? HoshiTextField)?.borderActiveColor = activeCursorColor
        (textField as? HoshiTextField)?.placeholderLabel.textColor = activeCursorColor
        
        if textField == txtLogin {
            loginSeparator.isHidden = true
        }
        if textField == txtPassword {
            passwordSeparator.isHidden = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? HoshiTextField)?.borderActiveColor = inactiveCursorColor
        (textField as? HoshiTextField)?.placeholderLabel.textColor = inactivePlaceholderColor
        
        if textField == txtLogin {
            loginSeparator.isHidden = false
        }
        if textField == txtPassword {
            passwordSeparator.isHidden = false
        }
    }
}
