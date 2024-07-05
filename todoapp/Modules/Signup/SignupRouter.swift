//
//  SignupRouter.swift
//  todoapp
//
//  Created by Juan Aguilar on 05/04/24.
//  
//

import Foundation
import UIKit

class SignupRouter {

    // MARK: Properties


    // MARK: Static methods

    static func createSignupModule() -> SignupViewController {
        let view = SignupViewController(nibName: "SignupViewController", bundle: nil)
        
        let presenter: SignupPresenterProtocol & SignupInteractorOutputProtocol = SignupPresenter()
        
        let interactor: SignupInteractorInputProtocol = SignupInteractor()
        
        let router: SignupRouterProtocol = SignupRouter()
        
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

extension SignupRouter: SignupRouterProtocol {
    // TODO: Implement wireframe methods
    
    func goToHomeView(fromView: BaseViewController?) {
        if let view = fromView {
            let homeView = HomeRouter.createHomeModule()
            view.navigationController?.pushViewController(homeView, animated: true)
        }
    }
}
