//
//  CreateDataElement.swift
//  
//
//  Created by Igor Leonovich on 26.07.21
//  Copyright © 2021 FT. All rights reserved.
//

import Fluent

struct CreateDataElementContainer: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("data-element-containers")
            .id()
            .field("userID", .uuid, .required, .references("users", "id"))
            .field("dataElementAliasID", .uuid, .references("data-element-aliases", "id"))
            .field("dataElementID", .uuid, .references("data-elements", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("data-element-containers").delete()
    }
}

struct CreateDataElementAlias: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("data-element-aliases")
            .id()
            .field("userID", .uuid, .required, .references("users", "id"))
            .field("dataElementID", .uuid, .references("data-elements", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("data-element-aliases").delete()
    }
}

struct CreateDataElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("data-elements")
            .id()
            .field("userID", .uuid, .required, .references("users", "id"))
            .field("text", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("data-elements").delete()
    }
}
