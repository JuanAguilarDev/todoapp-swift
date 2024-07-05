//
//  TaskListProtocols.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//  
//

import Foundation

protocol TaskListViewProtocol: BaseViewController {
    // PRESENTER -> VIEW
    
    var presenter: TaskListPresenterProtocol? { get set }
    
    func initView(state: TaskState)
    func setNavigationControllerHidden(isHidden: Bool) 
    func setTaskItems(task: [TaskModel]?)
    func setState(state: String) -> TaskState 
}

protocol TaskListRouterProtocol: AnyObject  {
    // PRESENTER -> ROUTER
    
    static func createTaskListModule(state: TaskState, model: [TaskModel]) -> TaskListViewController
    
    func goToCreateTaskView(fromView: BaseViewController?, state: TaskState?, model: TaskModel?)
}

protocol TaskListPresenterProtocol: AnyObject  {
    // VIEW -> PRESENTER
    
    var view: TaskListViewProtocol? { get set }
    var interactor: TaskListInteractorInputProtocol? { get set }
    var router: TaskListRouterProtocol? { get set }
    var state: TaskState? { get set }
    var model: [TaskModel]? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    
    func goToCreateTaskView(id: String?)
}

protocol TaskListInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
}

protocol TaskListInteractorInputProtocol: AnyObject {
    //PRESENTER -> INTERACTOR
    
    var presenter: TaskListInteractorOutputProtocol? { get set }
    var provider: TodoServicesManagerProtocol? { get set }

}
