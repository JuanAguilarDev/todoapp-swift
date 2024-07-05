//
//  HomeProtocols.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//  
//

import Foundation

protocol HomeViewProtocol: BaseViewController {
    // PRESENTER -> VIEW
    
    var presenter: HomePresenterProtocol? { get set }
    
    func initView()
    func setNavigationControllerHidden(isHidden: Bool)
    func setTaskItems(task: [TaskModel]?)
    func initFloatingButton()
    func setUsername()
    func setState(state: String) -> TaskState 
}

protocol HomeRouterProtocol: AnyObject  {
    // PRESENTER -> ROUTER
    
    static func createHomeModule() -> HomeViewController
    func goToTaskListView(fromView: BaseViewController?, state: TaskState?, tasks: [TaskModel])
    func goToCreateTaskView(fromView: BaseViewController?, state: TaskState?, model: TaskModel?) 
    func goToChatbotView(fromView: BaseViewController?)
}

protocol HomePresenterProtocol: AnyObject  {
    // VIEW -> PRESENTER
    
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    var onGoing: [TaskModel]? { get set }
    var completed: [TaskModel]? { get set }
    var todo: [TaskModel]? { get set }
    var completeArray: [TaskModel]? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func goToTaskListView(state: TaskState?)
    func goToCreateTaskView(isFromUpdate: Bool, id: String?)
    func goToChatbotView()
    
    func updateOnGoing(tasks: [TaskModel]?)
    func updateCompleted(tasks: [TaskModel]?)
    func updateTodo(tasks: [TaskModel]?)
    func updateCompleteArray(tasks: [TaskModel]?)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    
    func updateTasks(tasks: [TaskModel]?)
}

protocol HomeInteractorInputProtocol: AnyObject {
    //PRESENTER -> INTERACTOR
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    var provider: TodoServicesManagerProtocol? { get set }
    
    func getTasks()

}
