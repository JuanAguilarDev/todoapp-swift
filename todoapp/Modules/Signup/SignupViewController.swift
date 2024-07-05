//
//  SignupViewController.swift
//  todoapp
//
//  Created by Juan Aguilar on 05/04/24.
//  
//

import Foundation
import UIKit
import MaterialComponents

class SignupViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var loginButton: MDCButton!
    @IBOutlet weak var nameInput: MDCOutlinedTextField!
    @IBOutlet weak var username: MDCOutlinedTextField!
    @IBOutlet weak var password: MDCOutlinedTextField!
    
    
    var presenter: SignupPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    func setInputStyle(textField: MDCOutlinedTextField, _ text: String, _ helpText: String, _ iconName: String) {
        textField.label.text = text
        textField.placeholder = text
        textField.leadingAssistiveLabel.text = helpText
        textField.leadingView = createIcon(iconName)
        textField.leadingViewMode = .always
        textField.sizeToFit()
    }
    
    func createIcon(_ iconName: String) -> UIImageView {
        let leadingIcon = UIImageView(image: UIImage(systemName: iconName))
        leadingIcon.tintColor = .black
        
        return leadingIcon
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        if let nameText = nameInput.text, let usernameText = username.text, let passwordText = password.text, !nameText.isEmpty, !usernameText.isEmpty, !passwordText.isEmpty {
            presenter?.signUpUser(name: nameText, username: usernameText, password: passwordText)
        } else {
            presenter?.showBlanksError()
        }
    }
    
    
}


extension SignupViewController : SignupViewProtocol{
    // TODO: implement view output methods
    
    func initView() {
        setInputStyle(textField: username, "Username", "Type your username", "person")
        setInputStyle(textField: password, "Password", "Type your password", "key.horizontal")
        setInputStyle(textField: nameInput, "Name", "Type your name", "person.crop.circle")
        loginButton.layer.cornerRadius = 5
        password.isSecureTextEntry = true
    }
    
}
