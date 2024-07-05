//
//  HomePresenter.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//  
//

import Foundation


class HomePresenter {

    // MARK: Properties

    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol?
    var interactor: HomeInteractorInputProtocol?
    
    var onGoing: [TaskModel]?
    var completed: [TaskModel]?
    var todo: [TaskModel]?
    var completeArray: [TaskModel]?
}

extension HomePresenter: HomePresenterProtocol {
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.initView()
        view?.setNavigationControllerHidden(isHidden: true)
        view?.initFloatingButton()
        view?.setUsername()
    }
    
    func viewWillAppear() {
        interactor?.getTasks()
    }
    
    func viewDidAppear() {
        
    }
    
    func viewWillDissappear() {
        
    }
    
    func goToTaskListView(state: TaskState?) {
        router?.goToTaskListView(fromView: view, state: state, tasks: getModel(state: state))
    }
    
    func goToCreateTaskView(isFromUpdate: Bool, id: String?) {
        if isFromUpdate, let id = id {
            if let item = completeArray?.filter({ $0.id == id }) {
                let task = item[0]
                let state = view?.setState(state: task.state ?? "")
                router?.goToCreateTaskView(fromView: view, state: state, model: task)
            } else {
                router?.goToCreateTaskView(fromView: view, state: .NONE, model: nil)
            }
        } else {
            router?.goToCreateTaskView(fromView: view, state: .NONE, model: nil)
        }
    }
    
    func goToChatbotView() {
        router?.goToChatbotView(fromView: view)
    }
    
    func updateOnGoing(tasks: [TaskModel]?) {
        self.onGoing = tasks
    }
    
    func updateCompleted(tasks: [TaskModel]?) {
        self.completed = tasks
    }
    
    func updateTodo(tasks: [TaskModel]?) {
        self.todo = tasks
    }
    
    func updateCompleteArray(tasks: [TaskModel]?) {
        self.completeArray = tasks
    }
    
    func getModel(state: TaskState?) -> [TaskModel] {
        guard let state = state else { return [] }
        switch state {
        case .TODO:
            return todo ?? []
        case .COMPLETED:
            return completed ?? []
        case .ONGOING:
            return onGoing ?? []
        case .NONE:
            return []
        }
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func updateTasks(tasks: [TaskModel]?) {
        view?.setTaskItems(task: tasks)
    }
}
