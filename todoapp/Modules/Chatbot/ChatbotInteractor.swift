//
//  ChatbotInteractor.swift
//  todoapp
//
//  Created by Juan Aguilar on 16/05/24.
//  
//

import Foundation

class ChatbotInteractor {

    // MARK: Properties

    weak var presenter: ChatbotInteractorOutputProtocol?
    var provider: TodoServicesManagerProtocol?

}

extension ChatbotInteractor: ChatbotInteractorInputProtocol {
    // TODO: Implement use case methods
}
