//
//  HomeEntity.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//

import Foundation
import ObjectMapper

class Task: Mappable {
    var id: String?
    var title: String?
    var description: String?
    var userId: String?
    var state: String?
    
    required init?(map: Map){ }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        userId <- map["userId"]
        state <- map["state"]
    }
}

class TaskModel {
    var id: String?
    var title: String?
    var description: String?
    var userId: String?
    var state: String?
    
    init(id: String? = nil, title: String? = nil, description: String? = nil, userId: String? = nil, state: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.userId = userId
        self.state = state
    }
}
