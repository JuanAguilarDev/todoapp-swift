//
//  TasksPresenter.swift
//  todoapp
//
//  Created by Juan Aguilar on 09/04/24.
//  
//

import Foundation


class TasksPresenter {

    // MARK: Properties

    weak var view: TasksViewProtocol?
    var router: TasksRouterProtocol?
    var interactor: TasksInteractorInputProtocol?
    var state: TaskState?
    var model: TaskModel?
    
    init(state: TaskState? = nil, model: TaskModel?) {
        self.state = state
        self.model = model
    }
}

extension TasksPresenter: TasksPresenterProtocol {
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.initView()
        view?.setNavigationControllerHidden(isHidden: false)
        view?.setButtonConfiguration(currentState: state ?? .NONE)
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear() {
        
    }
    
    func viewWillDissappear() {
        
    }
    
    func viewWillDisappear() {
        view?.setNavigationControllerHidden(isHidden: true)
    }
    
    func createTask(title: String, description: String) {
        view?.showLoader()
        interactor?.createTask(title: title, description: description)
    }
    
    func initData() {
        view?.setInitialData(title: model?.title ?? "", description: model?.description ?? "")
    }
    
    func deleteTask() {
        guard let interactor = interactor, let model = model, let id = model.id else { return }
        interactor.deleteTask(id: id)
    }
    
    func updateTask(state: String, title: String, description: String) { // UPDATES VALUES FROM VIEW
        guard let interactor = interactor, let model = model, let id = model.id else { return }
        interactor.updateTask(id: id, title: title, description: description, state: state)
    }
    
    func updateTaskState(state: TaskState) {
        self.state = state
    }
    
    func showBlanksError() {
        let title = "Wait"
        let message = Utils.shared.fillBlanks
        view?.showAlert(title: title, message: message)
    }
}

extension TasksPresenter: TasksInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func goToHomeView(go: Bool) {
        if go {
            view?.hideLoader()
            view?.dismiss(animated: true)
            router?.goToHomeView(fromView: view)
        } else {
            let title = "Take a look!"
            view?.hideLoader()
            let message = Utils.shared.signUpError
            view?.showAlert(title: title, message: message)
        }
    }
}
