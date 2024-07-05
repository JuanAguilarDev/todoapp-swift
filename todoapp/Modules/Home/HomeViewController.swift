//
//  HomeViewController.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//
//

import Foundation
import UIKit
import MaterialComponents

class HomeViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet weak var todoCount: UILabel!
    @IBOutlet weak var completedCount: UILabel!
    @IBOutlet weak var onGoingCount: UILabel!
    @IBOutlet weak var onGoingView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var toDoView: UIView!
    @IBOutlet weak var tasksStack: UIStackView!
    @IBOutlet weak var noTasksView: UIView!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var completedImage: UIImageView!
    @IBOutlet weak var onGoingRoundedView: UIView!
    @IBOutlet weak var toDoRoundedView: UIView!
    @IBOutlet weak var completedRoundedView: UIView!
    
    var presenter: HomePresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    @IBAction func goToOnGoing(_ sender: Any) {
        presenter?.goToTaskListView(state: .ONGOING)
    }
    
    @IBAction func goToDo(_ sender: Any) {
        presenter?.goToTaskListView(state: .TODO)
    }
    
    @IBAction func goToCompleted(_ sender: Any) {
        presenter?.goToTaskListView(state: .COMPLETED)
    }
    
    // Floating button
    @objc func tap(_ sender: Any) {
        presenter?.goToCreateTaskView(isFromUpdate: false, id: "")
    }
    
    @objc func chatbot(_ sender: Any) {
        presenter?.goToChatbotView()
    }
    
}


extension HomeViewController : HomeViewProtocol{
    // TODO: implement view output methods
    
    func initView() {
        completedView.layer.cornerRadius = 5
        toDoView.layer.cornerRadius = 5
        onGoingView.layer.cornerRadius = 5
        onGoingRoundedView.layer.cornerRadius = 20
        completedRoundedView.layer.cornerRadius = 20
        toDoRoundedView.layer.cornerRadius = 20
        completedImage.image = UIImage(systemName: "calendar")!
        
        completedCount.text = "0 Tasks"
        onGoingCount.text = "0 Tasks"
        todoCount.text = "0 Tasks"
    }
    
    func setUsername() {
        if let model = Utils.shared.model, let user = model.user, let name = user.name {
            username.text = "Hi, \(name)"
        }
    }
    
    func setNavigationControllerHidden(isHidden: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: isHidden)
    }
    
    func setState(state: String) -> TaskState {
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
    
    func removeArrangedSubviews() {
        for (index, subview) in tasksStack.subviews.enumerated() {
            if index != 0 {
                subview.removeFromSuperview()
            }
            
        }
    }
    
    func setTaskItems(task: [TaskModel]?) {
        if let tasks = task, !tasks.isEmpty {
            noTasksView.isHidden = true
            removeArrangedSubviews()
            for element in tasks {
                let newTask = ListItemView()
                newTask.delegate = self
                newTask.initView()
                newTask.initData(title: element.title ?? "", description: element.description ?? "", state:  setState(state: element.state ?? ""), id: element.id ?? "")
                tasksStack.addArrangedSubview(newTask)
            }
            
            tasksStack.layoutIfNeeded()
            
            let todo = tasks.filter { $0.state == "todo" }
            let onGoing = tasks.filter { $0.state == "inProgress" }
            let completed = tasks.filter { $0.state == "complete" }
            
            completedCount.text = "\(completed.count) Tasks"
            onGoingCount.text = "\(onGoing.count) Tasks"
            todoCount.text = "\(todo.count) Tasks"
            
            presenter?.updateCompleteArray(tasks: tasks)
            presenter?.updateTodo(tasks: todo)
            presenter?.updateCompleted(tasks: completed)
            presenter?.updateOnGoing(tasks: onGoing)
            
        } else {
            noTasksView.isHidden = false
        }
    }
    
    func initFloatingButton() {
        let floatingButton = MDCFloatingButton()
        let image = UIImage(systemName: "plus.circle.fill")
        floatingButton.sizeToFit()
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.setImage(image, for: .normal)
        floatingButton.setImageTintColor(.white, for: .normal)
        floatingButton.backgroundColor = UIColor(hex: Utils.shared.mainColor)
        floatingButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        view.addSubview(floatingButton)
        view.addConstraint(NSLayoutConstraint(item: floatingButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -64))
        view.addConstraint(NSLayoutConstraint(item: floatingButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -32))
        
        initHelpButton()
    }
    
    func initHelpButton() {
        let floatingButton = MDCFloatingButton()
        let image = UIImage(systemName: "info.circle.fill")
        floatingButton.sizeToFit()
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.setImage(image, for: .normal)
        floatingButton.setImageTintColor(.white, for: .normal)
        floatingButton.backgroundColor = UIColor(hex: Utils.shared.supportColor)
        floatingButton.addTarget(self, action: #selector(chatbot), for: .touchUpInside)
        view.addSubview(floatingButton)
        view.addConstraint(NSLayoutConstraint(item: floatingButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -134))
        view.addConstraint(NSLayoutConstraint(item: floatingButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -32))
    }
    
}

extension HomeViewController: ListItemViewProtocol {
    func onItemClicked(id: String) {
        presenter?.goToCreateTaskView(isFromUpdate: true, id: id)
    }
}
