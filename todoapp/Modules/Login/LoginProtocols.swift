//
//  LoginProtocols.swift
//  todoapp
//
//  Created by Juan Aguilar on 04/04/24.
//  
//

import Foundation
import UIKit

protocol LoginViewProtocol: BaseViewController {
    // PRESENTER -> VIEW
    
    var presenter: LoginPresenterProtocol? { get set }
    
    func initView()
}

protocol LoginRouterProtocol: AnyObject  {
    // PRESENTER -> ROUTER
    
    static func createLoginModule() -> LoginViewController
    
    func goToSignupView(fromView: BaseViewController?)
    func goToHomeView(fromView: BaseViewController?)
}

protocol LoginPresenterProtocol: AnyObject  {
    // VIEW -> PRESENTER
    
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    var model: LoginModel? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func authUser(username: String, password: String)
    func goToSignUpView()
    func showBlanksError()
}

protocol LoginInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    
    func goToHomeView(model: LoginModel?)
}

protocol LoginInteractorInputProtocol: AnyObject {
    //PRESENTER -> INTERACTOR
    
    var presenter: LoginInteractorOutputProtocol? { get set }
    var provider: TodoServicesManagerProtocol? { get set }

    func authUser(username: String, password: String)
}
