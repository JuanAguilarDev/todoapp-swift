//
//  ChatbotProtocols.swift
//  todoapp
//
//  Created by Juan Aguilar on 16/05/24.
//  
//

import Foundation

protocol ChatbotViewProtocol: BaseViewController {
    // PRESENTER -> VIEW
    
    var presenter: ChatbotPresenterProtocol? { get set }
    
    func initView()
    func setNavigationControllerHidden(isHidden: Bool)
    func loadHTMLContent()
}

protocol ChatbotRouterProtocol: AnyObject  {
    // PRESENTER -> ROUTER
    
    static func createChatbotModule() -> ChatbotViewController
}

protocol ChatbotPresenterProtocol: AnyObject  {
    // VIEW -> PRESENTER
    
    var view: ChatbotViewProtocol? { get set }
    var interactor: ChatbotInteractorInputProtocol? { get set }
    var router: ChatbotRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDissappear()
}

protocol ChatbotInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    
    
}

protocol ChatbotInteractorInputProtocol: AnyObject {
    //PRESENTER -> INTERACTOR
    
    var presenter: ChatbotInteractorOutputProtocol? { get set }
    var provider: TodoServicesManagerProtocol? { get set }

}
