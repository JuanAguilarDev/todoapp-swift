//
//  LoginRouter.swift
//  todoapp
//
//  Created by Juan Aguilar on 04/04/24.
//  
//

import Foundation
import UIKit

class LoginRouter {

    // MARK: Properties


    // MARK: Static methods

    static func createLoginModule() -> LoginViewController {
        let view = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        
        let router: LoginRouterProtocol = LoginRouter()
        
        let provider: TodoServicesManagerProtocol = TodoServicesManager()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.provider = provider
        
        return view
    }
}

extension LoginRouter: LoginRouterProtocol {
    // TODO: Implement wireframe methods
    
    func goToSignupView(fromView: BaseViewController?) {
        if let view = fromView {
            let signUpView = SignupRouter.createSignupModule()
            view.navigationController?.pushViewController(signUpView, animated: true)
        }
    }
    
    func goToHomeView(fromView: BaseViewController?) {
        if let view = fromView {
            let homeView = HomeRouter.createHomeModule()
            view.navigationController?.pushViewController(homeView, animated: true)
        }
    }
}
