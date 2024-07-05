//
//  HomeInteractor.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//  
//

import Foundation

class HomeInteractor {

    // MARK: Properties

    weak var presenter: HomeInteractorOutputProtocol?
    var provider: TodoServicesManagerProtocol?

}

extension HomeInteractor: HomeInteractorInputProtocol {
    // TODO: Implement use case methods
    
    func getTasks() {
        provider?.getTasks({ [weak self] data in
            guard let self = self else { return }
            
            if !data.isEmpty {
                var model: [TaskModel] = []
                for task in data {
                    let newTask = TaskModel(id: task.id, title: task.title, description: task.description, userId: task.userId, state: task.state)
                    model.append(newTask)
                }
                
                self.presenter?.updateTasks(tasks: model)
            } else {
                self.presenter?.updateTasks(tasks: nil)
            }
        })
    }
}
