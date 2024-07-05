//
//  ChatbotRouter.swift
//  todoapp
//
//  Created by Juan Aguilar on 16/05/24.
//  
//

import Foundation
import UIKit

class ChatbotRouter {

    // MARK: Properties


    // MARK: Static methods

    static func createChatbotModule() -> ChatbotViewController {
        let view = ChatbotViewController(nibName: "ChatbotViewController", bundle: nil)
        
        let presenter: ChatbotPresenterProtocol & ChatbotInteractorOutputProtocol = ChatbotPresenter()
        
        let interactor: ChatbotInteractorInputProtocol = ChatbotInteractor()
        
        let router: ChatbotRouterProtocol = ChatbotRouter()
        
        let provider: TodoServicesManagerProtocol = TodoServicesManager()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.provider = provider
        
        return view
    }
}

extension ChatbotRouter: ChatbotRouterProtocol {
    // TODO: Implement wireframe methods
}
