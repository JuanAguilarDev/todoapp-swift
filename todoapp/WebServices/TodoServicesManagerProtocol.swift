//
//  TodoServicesManagerProtocol.swift
//  todoapp
//
//  Created by Juan Aguilar on 04/04/24.
//

import Foundation

protocol TodoServicesManagerProtocol : AnyObject {
    // MARK: Functions for the manager
    
    func authUser(username: String, password: String, _ completion: @escaping (LoginEntity) -> Void)
    
    func signUpUser(username: String, password: String, name: String, _ completion: @escaping (LoginEntity) -> Void)
    
    func createTask(title: String, description: String, _ completion: @escaping (TaskEntity) -> Void)
    
    func getTasks(_ completion: @escaping ([TaskEntity]) -> Void)
    
    func updateTask(id: String, title: String, description: String, state: String, _ completion: @escaping (TaskEntity) -> Void)
    
    func deleteTask(id: String, _ completion: @escaping (TaskEntity) -> Void)
}
