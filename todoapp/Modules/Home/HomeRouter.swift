//
//  HomeRouter.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//  
//

import Foundation
import UIKit

class HomeRouter {

    // MARK: Properties


    // MARK: Static methods

    static func createHomeModule() -> HomeViewController {
        let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
        
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        
        let interactor: HomeInteractorInputProtocol = HomeInteractor()
        
        let router: HomeRouterProtocol = HomeRouter()
        
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

extension HomeRouter: HomeRouterProtocol {
    // TODO: Implement wireframe methods
    
    func goToTaskListView(fromView: BaseViewController?, state: TaskState?, tasks: [TaskModel]) {
        if let view = fromView, let state = state {
            let taskView = TaskListRouter.createTaskListModule(state: state, model: tasks)
            view.navigationController?.pushViewController(taskView, animated: true)
        }
    }
    
    func goToCreateTaskView(fromView: BaseViewController?, state: TaskState?, model: TaskModel?) {
        if let view = fromView {
            let newTaskView = TasksRouter.createTasksModule(state: state ?? .NONE, model: model)
            view.navigationController?.pushViewController(newTaskView, animated: true)
        }
    }
    
    func goToChatbotView(fromView: BaseViewController?) {
        if let view = fromView {
            let newChatbotView = ChatbotRouter.createChatbotModule()
            view.navigationController?.pushViewController(newChatbotView, animated: true)
        }
    }
}
