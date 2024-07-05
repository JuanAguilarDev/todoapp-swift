//
//  TodoServicesManager.swift
//  todoapp
//
//  Created by Juan Aguilar on 04/04/24.
//

import Foundation
import Alamofire
import ObjectMapper

class TodoServicesManager : TodoServicesManagerProtocol {
    // MARK: Implementation of functions
    
    let concurrentQueve = DispatchQueue(label: "services", attributes: .concurrent)
    
    // UPDATE TASK
    
    func updateTask(id: String, title: String, description: String, state: String, _ completion: @escaping (TaskEntity) -> Void) {
        let token: String = Utils.shared.model?.token ?? ""
        
        let params: Parameters = [
            "title": title,
            "description": description,
            "status": state
        ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let requestModel = AsyncClientTodoRequestModel.RequestModelBuilder()
            .service(service: .UPDATE_TASK)
            .httpMethod(httpMethod: .PUT)
            .bodyParams(bodyParams: params)
            .key1(key: id)
            .headers(httpHeader: headers)
            .build()
        
        self.callService(requestModel: requestModel) { (dataResponse: TaskEntity?) in
            if let data = dataResponse {
                completion(data)
            }
        }
    }
    
    
    //DELETE TASK
    func deleteTask(id: String, _ completion: @escaping (TaskEntity) -> Void) {
        let token: String = Utils.shared.model?.token ?? ""
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let requestModel = AsyncClientTodoRequestModel.RequestModelBuilder()
            .service(service: .DELETE_TASK)
            .httpMethod(httpMethod: .DELETE)
            .key1(key: id)
            .headers(httpHeader: headers)
            .build()
        
        self.callService(requestModel: requestModel) { (dataResponse: TaskEntity?) in
            if let data = dataResponse {
                completion(data)
            }
        }
    }
    
    // GET TASKS
    func getTasks(_ completion: @escaping ([TaskEntity]) -> Void) {
        let token: String = Utils.shared.model?.token ?? ""
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let requestModel = AsyncClientTodoRequestModel.RequestModelBuilder()
            .service(service: .CREATE_TASK)
            .headers(httpHeader: headers)
            .build()
        
        self.callServiceForArray(requestModel: requestModel) { (dataResponse: [TaskEntity]?) in
            if let data = dataResponse {
                completion(data)
            }
        }
    }
    
    // CREATE TASK
    func createTask(title: String, description: String, _ completion: @escaping (TaskEntity) -> Void) {
        let token: String = Utils.shared.model?.token ?? ""
        
        let params: Parameters = [
            "title": title,
            "description": description
        ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        let requestModel = AsyncClientTodoRequestModel.RequestModelBuilder()
            .service(service: .CREATE_TASK)
            .bodyParams(bodyParams: params)
            .httpMethod(httpMethod: .POST)
            .headers(httpHeader: headers)
            .build()
        
        self.callService(requestModel: requestModel) { (dataResponse: TaskEntity?) in
            if let data = dataResponse {
                completion(data)
            }
        }
    }
    
    // AUTH
    func authUser(username: String, password: String, _ completion: @escaping (LoginEntity) -> Void) {
        let params: Parameters = [
            "password": password,
            "username": username
        ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json",
        ]
        
        let requestModel = AsyncClientTodoRequestModel.RequestModelBuilder()
            .service(service: .AUTH_USER)
            .bodyParams(bodyParams: params)
            .httpMethod(httpMethod: .POST)
            .headers(httpHeader: headers)
            .build()
        
        self.callService(requestModel: requestModel) { (dataResponse: LoginEntity?) in
            if let data = dataResponse {
                completion(data)
            }
        }
    }
    
    // SIGNUP
    func signUpUser(username: String, password: String, name: String, _ completion: @escaping (LoginEntity) -> Void) {
        let params: Parameters = [
            "password": password,
            "username": username,
            "name": name
        ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let requestModel = AsyncClientTodoRequestModel.RequestModelBuilder()
            .service(service: .SIGN_UP)
            .bodyParams(bodyParams: params)
            .httpMethod(httpMethod: .POST)
            .headers(httpHeader: headers)
            .build()
        
        self.callService(requestModel: requestModel) { (dataResponse: LoginEntity?) in
            if let data = dataResponse {
                completion(data)
            }
        }
    }
    
    
    // MARK: Custom functions
    private func callService<T:Mappable>(requestModel: AsyncClientTodoRequestModel, successBlock: @escaping(_ dataResponse: T?) -> Void){
        concurrentQueve.async {
            AsyncClientRequest.shared.callServiceInternal(requestModel: requestModel) { (result: Result<T, Error>?) in
                switch result {
                case .success(let data):
                    successBlock(data)
                case .failure(_):
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    private func callServiceForArray<T:Mappable>(requestModel: AsyncClientTodoRequestModel, successBlock: @escaping(_ dataResponse: [T]?) -> Void){
        concurrentQueve.async {
            AsyncClientRequest.shared.callServiceForArray(requestModel: requestModel) { (result: Result<[T], Error>?) in
                switch result {
                case .success(let data):
                    successBlock(data)
                case .failure(_):
                    return
                case .none:
                    return
                }
            }
        }
    }
}
