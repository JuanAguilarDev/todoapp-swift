//
//  TaskListEntity.swift
//  todoapp
//
//  Created by Juan Aguilar on 08/04/24.
//

import Foundation
import ObjectMapper

class TaskEntity: Mappable {
    var id: String?
    var title: String?
    var description: String?
    var userId: String?
    var state: String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        userId <- map["userId"]
        state <- map["state"]
    }
}

enum TaskState {
    case TODO
    case COMPLETED
    case ONGOING
    case NONE
    
    var title: String {
        switch self {
        case .COMPLETED:
            return "Completed"
        case .TODO:
            return "To Do"
        case .ONGOING:
            return "On Going"
        case .NONE:
            return "none"
        }
    }
    
    var imageName: String {
        switch self {
        case .COMPLETED:
            return "completed"
        case .ONGOING:
            return "ongoing"
        case .TODO:
            return "todo"
        case .NONE:
            return "none"
        }
    }
    
    var color: String {
        switch self {
        case .TODO:
            return "53C2C5"
        case .COMPLETED:
            return "4A934A"
        case .ONGOING:
            return "FEC347"
        case .NONE:
            return "CB1E47"
        }
    }
 
    var schemeState: String {
        switch self {
        case .TODO:
            return "todo"
        case .COMPLETED:
            return "complete"
        case .ONGOING:
            return "inProgress"
        case .NONE:
            return "todo"
        }
    }
}
