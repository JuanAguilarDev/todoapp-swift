//
//  LoginViewController.swift
//  todoapp
//
//  Created by Juan Aguilar on 04/04/24.
//
//

import Foundation
import UIKit
import MaterialComponents

class LoginViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet weak var username: MDCOutlinedTextField!
    @IBOutlet weak var password: MDCOutlinedTextField!
    @IBOutlet weak var loginButton: MDCButton!
    @IBOutlet weak var signUpButton: MDCButton!
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        initView() // STORYBOARD
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        initateStoryBoard() // STORYBOARD
    }
    
    func createIcon(_ iconName: String) -> UIImageView {
        let leadingIcon = UIImageView(image: UIImage(systemName: iconName))
        leadingIcon.tintColor = .black
        
        return leadingIcon
    }
    
    func setInputStyle(textField: MDCOutlinedTextField, _ text: String, _ helpText: String, _ iconName: String) {
        textField.label.text = text
        textField.placeholder = text
        textField.leadingAssistiveLabel.text = helpText
        textField.leadingView = createIcon(iconName)
        textField.leadingViewMode = .always
        textField.sizeToFit()
    }
    
    func initateStoryBoard() {
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        
        let router: LoginRouterProtocol = LoginRouter()
        
        let provider: TodoServicesManagerProtocol = TodoServicesManager()
        
        self.presenter = presenter
        presenter.view = self
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.provider = provider
    }
    
    // MARK: Actions
    @IBAction func loginAction(_ sender: Any) {
        guard let presenter = presenter else { return }
        if let usernameText = username.text, let passwordText = password.text, !passwordText.isEmpty, !usernameText.isEmpty {
            presenter.authUser(username: usernameText, password: passwordText)
        } else {
            presenter.showBlanksError()
        }
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        presenter?.goToSignUpView()
    }
    
}


extension LoginViewController : LoginViewProtocol{
    // TODO: implement view output methods
    
    func initView() {
        self.title = "Welcome Back!"
        setInputStyle(textField: username, "Username", "Type your username", "person")
        setInputStyle(textField: password, "Password", "Type your password", "key.horizontal")
        password.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 5
        signUpButton.layer.cornerRadius = 5
    }
    
}
