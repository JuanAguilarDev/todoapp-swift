//
//  TaskListPresenter.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//  
//

import Foundation


class TaskListPresenter {

    // MARK: Properties

    weak var view: TaskListViewProtocol?
    var router: TaskListRouterProtocol?
    var interactor: TaskListInteractorInputProtocol?
    var state: TaskState?
    var model: [TaskModel]?
    
    init(state: TaskState? = nil, model: [TaskModel]?) {
        self.state = state
        self.model = model
    }
}

extension TaskListPresenter: TaskListPresenterProtocol {
    // TODO: implement presentation methods
    func viewDidLoad() {
        guard let view = view, let state = state else { return }
        view.initView(state: state)
        view.setTaskItems(task: model)
    }
    
    func viewWillAppear() {
        view?.setNavigationControllerHidden(isHidden: false)
    }
    
    func viewDidAppear() {
        
    }
    
    func viewWillDisappear() {
        view?.setNavigationControllerHidden(isHidden: true)
    }
    
    func goToCreateTaskView(id: String?) {
        if let id = id {
            if let item = model?.filter({ $0.id == id }) {
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
}

extension TaskListPresenter: TaskListInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
