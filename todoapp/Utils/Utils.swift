//
//  Utils.swift
//  todoapp
//
//  Created by Juan Aguilar on 06/04/24.
//

import Foundation
import KVNProgress
import MaterialComponents

class Utils {
    
    static let shared = Utils()
    var model: LoginModel?

    // Colors
    let mainColor = "CB1E47"
    let onGoingColor = "FEC347"
    let toDoColor = "53C2C5"
    let completedColor = "4A934A"
    let supportColor = "0275d8"
    
    // Messages
    let loginError: String = "Ooops, it seems that the user or password does not match."
    let signUpError: String = "Ooops, we are having problems, try again later."
    let fillBlanks: String = "Ooops, all fields should be filled in."
    
    func newUser(model: LoginModel) {
        self.model = model
    }
    
    // WebView
    
    let html = """
            <html>
              <head>
                <meta name="viewport" content="width=device-width, initial-scale=1" />
              </head>
              <body>
                <script>
            window.watsonAssistantChatOptions = {
              // A UUID like '1d7e34d5-3952-4b86-90eb-7c7232b9b540' included in the embed code.
              integrationID: "b3bc120d-f424-42de-9cb6-e14200cd1460",
              // Your assistants region e.g. 'us-south', 'us-east', 'jp-tok' 'au-syd', 'eu-gb', 'eu-de', etc.
              region: "us-south",
              // A UUID like '6435434b-b3e1-4f70-8eff-7149d43d938b' included in the embed code.
              serviceInstanceID: "5272f902-ba0f-4062-b728-f57ac32a562a",
              // The callback function that is called after the widget instance has been created.
              onLoad: function(instance) {
                instance.render();
              },
              showLauncher: false, // Hide the web chat launcher, you will open the WebView from your mobile application
              openChatByDefault: true, // When the web chat WebView is opened, the web chat will already be open and ready to go.
              hideCloseButton: true // And the web chat will not show a close button, instead relying on the controls to close the WebView
            };
            setTimeout(function(){const t=document.createElement('script');t.src="https://web-chat.global.assistant.watson.appdomain.cloud/versions/" + (window.watsonAssistantChatOptions.clientVersion || 'latest') + "/WatsonAssistantChatEntry.js";document.head.appendChild(t);});
                </script>
              </body>
            </html>
            """

}

class ProgressLoader : UIView {
    private let progressView: MDCProgressView = {
        let progressView = MDCProgressView()
        progressView.progress = 0
        progressView.mode = .indeterminate
        progressView.trackTintColor = UIColor.clear
        progressView.progressTintColor = UIColor(hex: Utils.shared.mainColor)
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProgressView()
    }
    
    private func setupProgressView() {
        addSubview(progressView)
        progressView.frame = bounds
        progressView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func startAnimating() {
        progressView.startAnimating()
    }
    
    func stopAnimating() {
        progressView.stopAnimating()
    }
}


class BaseViewController: UIViewController {
    
    let progressLoader = ProgressLoader()
    
    func showLoader() {
        self.view.isUserInteractionEnabled = false
        progressLoader.frame = view.bounds
        view.addSubview(progressLoader)
        progressLoader.startAnimating()
    }
    
    func hideLoader() {
        self.view.isUserInteractionEnabled = true
        self.progressLoader.removeFromSuperview()
        progressLoader.stopAnimating()
    }
    
    func showAlert(title: String, message: String) {
        let alertController = MDCAlertController(title: title, message: message)

        let action = MDCAlertAction(title: "OK") { (action) in }
        alertController.addAction(action)

        present(alertController, animated: true, completion: nil)
    }
}
