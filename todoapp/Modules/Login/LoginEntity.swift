//
//  LoginEntity.swift
//  todoapp
//
//  Created by Juan Aguilar on 05/04/24.
//

import Foundation
import ObjectMapper

class LoginEntity : Mappable {
    var user: User?
    var token: String?
    var message: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        user <- map["user"]
        token <- map["token"]
        message <- map["message"]
    }
}


class User : Mappable {
    var id: String?
    var name: String?
    var username: String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        username <- map["username"]
    }
}

class LoginModel {
    var user: UserModel?
    var token: String?
    var message: String?
    
    init(user: UserModel? = nil, token: String? = nil, message: String? = nil) {
        self.user = user
        self.token = token
        self.message = message
    }
}

class UserModel {
    var id: String?
    var name: String?
    var username: String?
    
    init(id: String? = nil, name: String? = nil, username: String? = nil) {
        self.id = id
        self.name = name
        self.username = username
    }
}
