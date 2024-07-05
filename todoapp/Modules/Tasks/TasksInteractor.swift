//
//  TasksInteractor.swift
//  todoapp
//
//  Created by Juan Aguilar on 09/04/24.
//  
//

import Foundation

class TasksInteractor {

    // MARK: Properties

    weak var presenter: TasksInteractorOutputProtocol?
    var provider: TodoServicesManagerProtocol?

}

extension TasksInteractor: TasksInteractorInputProtocol {
    // TODO: Implement use case methods
    
    func createTask(title: String, description: String) {
        provider?.createTask(title: title, description: description, { [weak self] data in
            guard let self = self else { return }
            if let _ = data.id {
                self.presenter?.goToHomeView(go: true)
            } else {
                self.presenter?.goToHomeView(go: false)
            }
        })
    }
    
    func deleteTask(id: String) {
        provider?.deleteTask(id: id, { [weak self] data in
            guard let self = self else { return }
            if let _ = data.id {
                self.presenter?.goToHomeView(go: true)
            } else {
                self.presenter?.goToHomeView(go: false)
            }
        })
    }
    
    func updateTask(id: String, title: String, description: String, state: String) {
        provider?.updateTask(id: id, title: title, description: description, state: state, { [weak self] data in
            guard let self = self else { return }
            if let _ = data.id {
                self.presenter?.goToHomeView(go: true)
            } else {
                self.presenter?.goToHomeView(go: false)
            }
        })
    }
}
