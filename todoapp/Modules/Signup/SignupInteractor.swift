//
//  SignupInteractor.swift
//  todoapp
//
//  Created by Juan Aguilar on 05/04/24.
//  
//

import Foundation

class SignupInteractor {

    // MARK: Properties

    weak var presenter: SignupInteractorOutputProtocol?
    var provider: TodoServicesManagerProtocol?

}

extension SignupInteractor: SignupInteractorInputProtocol {
    // TODO: Implement use case methods
    
    func signUpUser(name: String, username: String, password: String) {
        provider?.signUpUser(username: username, password: password, name: name, { [weak self] data in
            if let user = data.user, let self = self  {
                let model = LoginModel(user: UserModel(id: user.id, name: user.name, username: user.username), token: data.token, message: data.message)
                self.presenter?.goToHomeView(model: model)
            } else if let self = self {
                self.presenter?.goToHomeView(model: nil)
            }
        })
    }
}
