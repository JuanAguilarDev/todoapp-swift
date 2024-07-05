//
//  LoginInteractor.swift
//  todoapp
//
//  Created by Juan Aguilar on 04/04/24.
//  
//

import Foundation

class LoginInteractor {

    // MARK: Properties

    weak var presenter: LoginInteractorOutputProtocol?
    var provider: TodoServicesManagerProtocol?

}

extension LoginInteractor: LoginInteractorInputProtocol {
    // TODO: Implement use case methods
    
    func authUser(username: String, password: String) {
        provider?.authUser(username: username, password: password, { [weak self] data in
            if let _ = data.user, let self = self  {
                let model = LoginModel(user: UserModel(id: data.user?.id, name: data.user?.name, username: data.user?.username), token: data.token, message: data.message)
                self.presenter?.goToHomeView(model: model)
            } else if let self = self {
                self.presenter?.goToHomeView(model: nil)
            }
        })
    }
}
