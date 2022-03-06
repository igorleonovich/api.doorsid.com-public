//
//  DataElementContainer.swift
//  
//
//  Created by Igor Leonovich on 26.07.21
//  Copyright © 2021 FT. All rights reserved.
//

import Vapor
import Fluent

final class DataElementContainer: Model, Codable {
  
    static let schema = "data-element-containers"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @OptionalParent(key: "dataElementAlias")
    var dataElementAlias: DataElementAlias?
    
    @OptionalParent(key: "dataElement")
    var dataElement: DataElement?

    init() {}

    init(id: UUID? = nil, userID: User.IDValue, dataElementAliasID: DataElementAlias.IDValue? = nil, dataElementID: DataElement.IDValue? = nil) {
        self.id = id
        self.$user.id = userID
        self.$dataElementAlias.id = dataElementAliasID
        self.$dataElement.id = dataElementID
    }
}

final class DataElementAlias: Model, Codable {
    
    static let schema = "data-element-aliases"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @Parent(key: "dataElementID")
    var dataElement: DataElement
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue, dataElementID: DataElement.IDValue) {
        self.id = id
        self.$user.id = userID
        self.$dataElement.id = dataElementID
    }
}

final class DataElement: Model, Codable {
    
    static let schema = "data-elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @OptionalField(key: "text")
    var text: String?
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue, text: String? = nil) {
        self.id = id
        self.$user.id = userID
        self.text = text
    }
}
