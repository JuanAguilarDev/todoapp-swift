//
//  TaskListRouter.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//  
//

import Foundation
import UIKit

class TaskListRouter {

    // MARK: Properties


    // MARK: Static methods

    static func createTaskListModule(state: TaskState, model: [TaskModel]) -> TaskListViewController {
        let view = TaskListViewController(nibName: "TaskListViewController", bundle: nil)
        
        let presenter: TaskListPresenterProtocol & TaskListInteractorOutputProtocol = TaskListPresenter(state: state, model: model)
        
        let interactor: TaskListInteractorInputProtocol = TaskListInteractor()
        
        let router: TaskListRouterProtocol = TaskListRouter()
        
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

extension TaskListRouter: TaskListRouterProtocol {
    // TODO: Implement wireframe methods
    
    func goToCreateTaskView(fromView: BaseViewController?, state: TaskState?, model: TaskModel?) {
        if let view = fromView {
            let newTaskView = TasksRouter.createTasksModule(state: state ?? .NONE, model: model)
            view.navigationController?.pushViewController(newTaskView, animated: true)
        }
    }
}
