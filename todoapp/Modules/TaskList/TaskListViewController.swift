//
//  TaskListViewController.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//  
//

import Foundation
import UIKit

class TaskListViewController: BaseViewController {

    // MARK: Properties
    @IBOutlet weak var imageCategory: UIImageView!
    @IBOutlet weak var itemsStack: UIStackView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var noTasksView: UIView!
    
    
    var presenter: TaskListPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            presenter?.viewWillDisappear()
        }
    }
    
    func setInitalValues(state: TaskState){
        let initText: String = " Tasks"
        titleView.text = state.title + initText
        imageCategory.image = UIImage(named: state.imageName)
    }
    
    func removeArrangedSubviews() {
        for (index, subview) in itemsStack.subviews.enumerated() {
            if index != 0 {
                subview.removeFromSuperview()
            }
            
        }
    }
    
    func setState(state: String) -> TaskState{
        switch state {
        case "todo":
            return .TODO
        case "inProgress":
            return .ONGOING
        case "complete":
            return .COMPLETED
        default:
            return .NONE
        }
    }
    
    func setTaskItems(task: [TaskModel]?) {
        if let tasks = task, !tasks.isEmpty {
            noTasksView.isHidden = true
            removeArrangedSubviews()
            for element in tasks {
                let newTask = ListItemView()
                newTask.initView()
                newTask.delegate = self
                newTask.initData(title: element.title ?? "", description: element.description ?? "", state:  setState(state: element.state ?? ""), id: element.id ?? "")
                itemsStack.addArrangedSubview(newTask)
            }
            
            itemsStack.layoutIfNeeded()
            
        } else {
            noTasksView.isHidden = false
        }
    }
    
}


extension TaskListViewController : TaskListViewProtocol{
    // TODO: implement view output methods
    
    func initView(state: TaskState) {
        switch state {
        case .COMPLETED:
            setInitalValues(state: .COMPLETED)
            break
        case .ONGOING:
            setInitalValues(state: .ONGOING)
            break
        case .TODO:
            setInitalValues(state: .TODO)
            break
        case .NONE:
            setInitalValues(state: .NONE)
        }
    }
    
    func setNavigationControllerHidden(isHidden: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: isHidden)
    }
}

extension TaskListViewController: ListItemViewProtocol {
    func onItemClicked(id: String) {
        presenter?.goToCreateTaskView(id: id)
    }
}
