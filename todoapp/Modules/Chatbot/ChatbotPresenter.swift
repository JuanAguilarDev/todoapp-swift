//
//  ChatbotPresenter.swift
//  todoapp
//
//  Created by Juan Aguilar on 16/05/24.
//  
//

import Foundation


class ChatbotPresenter {

    // MARK: Properties

    weak var view: ChatbotViewProtocol?
    var router: ChatbotRouterProtocol?
    var interactor: ChatbotInteractorInputProtocol?
}

extension ChatbotPresenter: ChatbotPresenterProtocol {
    
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.initView()
        view?.loadHTMLContent()
        view?.setNavigationControllerHidden(isHidden: false)
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear() {
        
    }
    
    func viewWillDissappear() {
        view?.setNavigationControllerHidden(isHidden: true)
    }
}

extension ChatbotPresenter: ChatbotInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
