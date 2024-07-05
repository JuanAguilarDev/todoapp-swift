//
//  SignupProtocols.swift
//  todoapp
//
//  Created by Juan Aguilar on 05/04/24.
//  
//

import Foundation

protocol SignupViewProtocol: BaseViewController {
    // PRESENTER -> VIEW
    
    var presenter: SignupPresenterProtocol? { get set }
    
    func initView()
}

protocol SignupRouterProtocol: AnyObject  {
    // PRESENTER -> ROUTER
    
    static func createSignupModule() -> SignupViewController
    
    func goToHomeView(fromView: BaseViewController?)
    
}

protocol SignupPresenterProtocol: AnyObject  {
    // VIEW -> PRESENTER
    
    var view: SignupViewProtocol? { get set }
    var interactor: SignupInteractorInputProtocol? { get set }
    var router: SignupRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func signUpUser(name: String?, username: String?, password: String?)
    func showBlanksError()
}

protocol SignupInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    
    func goToHomeView(model: LoginModel?)
}

protocol SignupInteractorInputProtocol: AnyObject {
    //PRESENTER -> INTERACTOR
    
    var presenter: SignupInteractorOutputProtocol? { get set }
    var provider: TodoServicesManagerProtocol? { get set }
    
    func signUpUser(name: String, username: String, password: String)

}
