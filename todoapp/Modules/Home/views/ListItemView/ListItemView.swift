//
//  ListItemView.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//

import Foundation
import UIKit

protocol ListItemViewProtocol {
    func onItemClicked(id: String)
}

class ListItemView: UIView {
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet var view: UIView!
    
    var delegate: ListItemViewProtocol?
    var id: String = ""
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 353, height: 120)
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(ListItemView.identifier, owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func initData(title: String, description: String, state: TaskState, id: String) {
        self.title.text = title
        self.taskDescription.text = description
        self.darkView.backgroundColor = UIColor(hex: state.color)
        self.id = id
    }
    
    func initView() {
        darkView.layer.cornerRadius = 10
        whiteView.layer.borderWidth = 1.0
        whiteView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        whiteView.layer.cornerRadius = 5
    }
    
    func setBackViewColor(color: String) {
        darkView.backgroundColor = UIColor(hex: color)
    }
    
    
    @IBAction func onClickButton(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.onItemClicked(id: id)
    }
    
}
