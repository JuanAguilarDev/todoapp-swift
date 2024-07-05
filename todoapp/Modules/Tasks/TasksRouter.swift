//
//  TasksRouter.swift
//  todoapp
//
//  Created by Juan Aguilar on 09/04/24.
//  
//

import Foundation
import UIKit

class TasksRouter {

    // MARK: Properties


    // MARK: Static methods

    static func createTasksModule(state: TaskState?, model: TaskModel?) -> TasksViewController {
        let view = TasksViewController(nibName: "TasksViewController", bundle: nil)
        
        let presenter: TasksPresenterProtocol & TasksInteractorOutputProtocol = TasksPresenter(state: state, model: model)
        
        let interactor: TasksInteractorInputProtocol = TasksInteractor()
        
        let router: TasksRouterProtocol = TasksRouter()
        
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

extension TasksRouter: TasksRouterProtocol {
    // TODO: Implement wireframe methods
    
    func goToHomeView(fromView: BaseViewController?) {
        if let view = fromView {
            let homeView = HomeRouter.createHomeModule()
            view.navigationController?.pushViewController(homeView, animated: true)
        }
    }
}
