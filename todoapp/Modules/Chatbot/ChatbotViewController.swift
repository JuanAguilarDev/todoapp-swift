//
//  ChatbotViewController.swift
//  todoapp
//
//  Created by Juan Aguilar on 16/05/24.
//  
//

import Foundation
import UIKit
import MaterialComponents
import WebKit

class ChatbotViewController: BaseViewController {

    // MARK: Properties
    
    @IBOutlet weak var webView: WKWebView!
    var presenter: ChatbotPresenterProtocol?
    
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
        presenter?.viewWillDissappear()
    }
    
    func initView() {
        webView.scrollView.isScrollEnabled = false
    }

    func loadHTMLContent() {
        let html = Utils.shared.html
        webView.loadHTMLString(html, baseURL: nil)
    }
    
}


extension ChatbotViewController : ChatbotViewProtocol{
    
    // TODO: implement view output methods
    
    func setNavigationControllerHidden(isHidden: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: isHidden)
    }
    
}
