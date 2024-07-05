//
//  LoginPresenter.swift
//  todoapp
//
//  Created by Juan Aguilar on 04/04/24.
//  
//

import Foundation
import KVNProgress


class LoginPresenter {

    // MARK: Properties

    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol?
    var interactor: LoginInteractorInputProtocol?
    
    var model: LoginModel?
}

extension LoginPresenter: LoginPresenterProtocol {
    // TODO: implement presentation methods
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear() {
        
    }
    
    func viewWillDissappear() {
        
    }
    
    func authUser(username: String, password: String) {
        view?.showLoader()
        interactor?.authUser(username: username, password: password)
    }
    
    func goToSignUpView(){
        router?.goToSignupView(fromView: view)
    }
    
    func showBlanksError() {
        let title = "Wait"
        let message = Utils.shared.fillBlanks
        view?.showAlert(title: title, message: message)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func goToHomeView(model: LoginModel?) {
        view?.hideLoader()
        if let model = model, let router = router {
            Utils.shared.newUser(model: model)
            router.goToHomeView(fromView: view)
        } else {
            let title = "Take a look!"
            let message = Utils.shared.loginError
            view?.showAlert(title: title, message: message)
        }
    }
    
}
