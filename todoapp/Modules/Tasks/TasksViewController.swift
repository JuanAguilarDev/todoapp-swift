//
//  TasksViewController.swift
//  todoapp
//
//  Created by Juan Aguilar on 09/04/24.
//
//

import Foundation
import UIKit
import MaterialComponents

class TasksViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet weak var state: MDCButton!
    @IBOutlet weak var titleInput: MDCOutlinedTextField!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var descriptionInput: MDCOutlinedTextField!
    @IBOutlet weak var addButton: MDCButton!
    @IBOutlet weak var deleteButton: MDCButton!
    @IBOutlet weak var titleView: UILabel!
    var presenter: TasksPresenterProtocol?
    
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
    
    func setButtonStyles(currentState: TaskState) {
        presenter?.updateTaskState(state: currentState)
        state.setTitle(currentState.title, for: .normal)
        state.setBackgroundColor(UIColor(hex: currentState.color), for: .normal)
    }
    
    func createIcon(_ iconName: String) -> UIImageView {
        let leadingIcon = UIImageView(image: UIImage(systemName: iconName))
        leadingIcon.tintColor = .black
        
        return leadingIcon
    }
    
    func setInputStyle(textField: MDCOutlinedTextField, _ text: String, _ helpText: String, _ iconName: String) {
        textField.label.text = text
        textField.placeholder = text
        textField.leadingAssistiveLabel.text = helpText
        textField.leadingView = createIcon(iconName)
        textField.leadingViewMode = .always
        textField.sizeToFit()
    }
    
    // MARK: Actions
    @IBAction func addAction(_ sender: Any) {
        if let presenter = presenter, let _ = presenter.model {
            let state = presenter.state?.schemeState ?? "todo"
            if let title = titleInput.text, let description = descriptionInput.text, !title.isEmpty, !description.isEmpty {
                presenter.updateTask(state: state, title: title, description: description)
            } else {
                presenter.showBlanksError()
            }
        } else {
            if let title = titleInput.text, let description = descriptionInput.text, !title.isEmpty, !description.isEmpty {
                presenter?.createTask(title: title, description: description)
            } else {
                presenter?.showBlanksError()
            }
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        guard let presenter = presenter else { return }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Delete Task", style: .destructive, handler: { _ in
            presenter.deleteTask()
        }))
        alertController.addAction(UIAlertAction(title: "Not Now", style: .default, handler: { _ in }))
    
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func stateAction(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "To Do", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.setButtonStyles(currentState: .TODO)
        }))
        alertController.addAction(UIAlertAction(title: "On Going", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.setButtonStyles(currentState: .ONGOING)
        }))
        alertController.addAction(UIAlertAction(title: "Completed", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.setButtonStyles(currentState: .COMPLETED)
        }))
        
        present(alertController, animated: true, completion: nil)
    }
}


extension TasksViewController : TasksViewProtocol{
    // TODO: implement view output methods
    
    func initView() {
        setInputStyle(textField: titleInput, "Title", "Type a title for your task", "pencil.line")
        setInputStyle(textField: descriptionInput, "Description", "Type a title for your task", "note.text")
        addButton.layer.cornerRadius = 5
        deleteButton.layer.cornerRadius = 5
        if let presenter = presenter, let _ = presenter.model {
            stateView.isHidden = false
            deleteButton.isHidden = false
            addButton.setTitle("Update", for: .normal)
            titleView.text = "Update Task"
            presenter.initData()
        } else {
            stateView.isHidden = true
            deleteButton.isHidden = true
            addButton.setTitle("Add Task", for: .normal)
        }
    }
    
    func setNavigationControllerHidden(isHidden: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: isHidden)
    }
    
    func setButtonConfiguration(currentState: TaskState) {
        state.layer.cornerRadius = 5
        
        switch currentState {
        case .COMPLETED:
            setButtonStyles(currentState: .COMPLETED)
            break
        case .TODO:
            setButtonStyles(currentState: .TODO)
            break
        case .ONGOING:
            setButtonStyles(currentState: .ONGOING)
            break
        case .NONE:
            setButtonStyles(currentState: .NONE)
            break
        }
    }
    
    func setInitialData(title: String, description: String) {
        titleInput.text = title
        descriptionInput.text = description
    }
}
