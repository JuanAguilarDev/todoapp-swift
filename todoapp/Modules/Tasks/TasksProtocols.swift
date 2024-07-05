//
//  TasksProtocols.swift
//  todoapp
//
//  Created by Juan Aguilar on 09/04/24.
//  
//

import Foundation

protocol TasksViewProtocol: BaseViewController {
    // PRESENTER -> VIEW
    
    var presenter: TasksPresenterProtocol? { get set }
    
    func initView()
    func setNavigationControllerHidden(isHidden: Bool)
    func setButtonConfiguration(currentState: TaskState)
    func setInitialData(title: String, description: String)
}

protocol TasksRouterProtocol: AnyObject  {
    // PRESENTER -> ROUTER
    
    static func createTasksModule(state: TaskState?, model: TaskModel?) -> TasksViewController 
    func goToHomeView(fromView: BaseViewController?) 
}

protocol TasksPresenterProtocol: AnyObject  {
    // VIEW -> PRESENTER
    
    var view: TasksViewProtocol? { get set }
    var interactor: TasksInteractorInputProtocol? { get set }
    var router: TasksRouterProtocol? { get set }
    var state: TaskState? { get set }
    var model: TaskModel? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    
    func createTask(title: String, description: String)
    func initData()
    func deleteTask()
    func updateTask(state: String, title: String, description: String)
    func updateTaskState(state: TaskState)
    func showBlanksError()
}

protocol TasksInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    
    func goToHomeView(go: Bool)
}

protocol TasksInteractorInputProtocol: AnyObject {
    //PRESENTER -> INTERACTOR
    
    var presenter: TasksInteractorOutputProtocol? { get set }
    var provider: TodoServicesManagerProtocol? { get set }

    func createTask(title: String, description: String)
    func deleteTask(id: String)
    func updateTask(id: String, title: String, description: String, state: String)
}
