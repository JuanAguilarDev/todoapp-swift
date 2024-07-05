//
//  TaskListInteractor.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//  
//

import Foundation

class TaskListInteractor {

    // MARK: Properties

    weak var presenter: TaskListInteractorOutputProtocol?
    var provider: TodoServicesManagerProtocol?

}

extension TaskListInteractor: TaskListInteractorInputProtocol {
    // TODO: Implement use case methods
}
