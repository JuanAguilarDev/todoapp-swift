//
//  SignupPresenter.swift
//  todoapp
//
//  Created by Juan Aguilar on 05/04/24.
//  
//

import Foundation


class SignupPresenter {

    // MARK: Properties

    weak var view: SignupViewProtocol?
    var router: SignupRouterProtocol?
    var interactor: SignupInteractorInputProtocol?
}

extension SignupPresenter: SignupPresenterProtocol {
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.initView()
    }
    
    func viewWillAppear() {
    }
    
    func viewDidAppear() {
        
    }
    
    func viewWillDissappear() {
        
    }
    
    func signUpUser(name: String?, username: String?, password: String?) {
        guard let view = view, let interactor = interactor else { return }
        view.showLoader()
        if let name = name, let username = username, let password = password {
            interactor.signUpUser(name: name, username: username, password: password)
        } else {
            view.hideLoader()
            showBlanksError()
        }
    }
    
    func showBlanksError() {
        let title = "Wait"
        let message = Utils.shared.fillBlanks
        view?.showAlert(title: title, message: message)
    }
}

extension SignupPresenter: SignupInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func goToHomeView(model: LoginModel?) {
        guard let view = view else { return }
        view.hideLoader()
        
        if let model = model, let router = router {
            Utils.shared.newUser(model: model)
            router.goToHomeView(fromView: view)
        } else {
            let title = "Wait"
            let message = Utils.shared.signUpError
            view.showAlert(title: title, message: message)
        }
    }
        
}
