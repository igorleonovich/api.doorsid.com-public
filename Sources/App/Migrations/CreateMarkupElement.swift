//
//  CreateMarkupElement.swift
//  
//
//  Created by Igor Leonovich on 26.07.21
//  Copyright © 2021 FT. All rights reserved.
//

import Fluent

struct CreateMarkupElementContainer: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("markup-element-containers")
            .id()
            .field("userID", .uuid, .required, .references("users", "id"))
            .field("markupElementAliasID", .uuid, .references("markup-element-aliases", "id"))
            .field("markupElementID", .uuid, .references("markup-elements", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("markup-element-containers").delete()
    }
}

struct CreateMarkupElementAlias: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("markup-element-aliases")
            .id()
            .field("userID", .uuid, .required, .references("users", "id"))
            .field("markupElementID", .uuid, .required, .references("markup-elements", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("markup-element-aliases").delete()
    }
}

struct CreateMarkupElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.enum("markup_element_types")
            .case("orderedUnordered")
            .case("pointAction")
            .case("date")
            .case("byTime")
            .case("byTopic")
            .case("byX")
            .case("level")
            .case("plan")
            .create()
            .flatMap { markupElementType in
                return database.schema("markup-elements")
                    .id()
                    .field("userID", .uuid, .required, .references("users", "id"))
                    .field("type", markupElementType, .required, .custom("DEFAULT 'orderedUnordered'"))
                    .field("orderedUnorderedMarkupElementID", .uuid, .references("ordered-unordered-markup-elements", "id"))
                    .field("actionsPointsMarkupElementID", .uuid, .references("actions-points-markup-elements", "id"))
                    .field("dateMarkupElementID", .uuid, .references("date-markup-elements", "id"))
                    .field("byTimeMarkupElementID", .uuid, .references("by-time-markup-elements", "id"))
                    .field("byTopicMarkupElementID", .uuid, .references("by-topic-markup-elements", "id"))
                    .field("byXMarkupElementID", .uuid, .references("by-x-markup-elements", "id"))
                    .field("levelMarkupElementID", .uuid, .references("level-markup-elements", "id"))
                    .field("planMarkupElementID", .uuid, .references("plan-markup-elements", "id"))
                    .create()
            }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("markup-elements").delete().flatMap {
            return database.enum("markup_element_types").delete()
        }
    }
}

struct CreateOrderedUnorderedMarkupElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.enum("ordered_unordered_markup_element_types")
            .case("ordered")
            .case("unordered")
            .create()
            .flatMap { orderedUnorderedMarkupElementType in
                database.schema("ordered-unordered-markup-elements")
                .id()
                .field("userID", .uuid, .required, .references("users", "id"))
                .field("type", orderedUnorderedMarkupElementType, .required)
                .create()
            }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("ordered-unordered-markup-elements").delete().flatMap {
            return database.enum("ordered_unordered_markup_element_types").delete()
        }
    }
}

struct CreateActionsPointsMarkupElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.enum("actions_points_markup_element_types")
            .case("actions")
            .case("points")
            .create()
            .flatMap { actionsPointsMarkupElementType in
                database.schema("actions-points-markup-elements")
                .id()
                .field("userID", .uuid, .required, .references("users", "id"))
                .field("type", actionsPointsMarkupElementType, .required)
                .create()
            }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("actions-points-markup-elements").delete().flatMap {
            return database.enum("actions_points_markup_element_types").delete()
        }
    }
}

struct CreateDateMarkupElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("date-markup-elements")
            .id()
            .field("userID", .uuid, .required, .references("users", "id"))
            .field("date", .date, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("date-markup-elements").delete()
    }
}

struct CreateByTimeMarkupElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.enum("by_time_markup_element_types")
            .case("before")
            .case("now")
            .case("next")
            .create()
            .flatMap { byTimeMarkupElementType in
                database.schema("by-time-markup-elements")
                .id()
                .field("userID", .uuid, .required, .references("users", "id"))
                .field("type", byTimeMarkupElementType, .required)
                .create()
            }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("by-time-markup-elements").delete().flatMap {
            return database.enum("by_time_markup_element_types").delete()
        }
    }
}

struct CreateByTopicMarkupElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("by-topic-markup-elements")
            .id()
            .field("userID", .uuid, .required, .references("users", "id"))
            .field("topic", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("by-topic-markup-elements").delete()
    }
}

struct CreateByXMarkupElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.enum("by_x_markup_element_types")
            .case("time")
            .case("topic")
            .create()
            .flatMap { byXMarkupElementType in
                database.schema("by-x-markup-elements")
                .id()
                .field("userID", .uuid, .required, .references("users", "id"))
                .field("type", byXMarkupElementType, .required)
                .create()
            }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("by-x-markup-elements").delete().flatMap {
            return database.enum("by_x_markup_element_types").delete()
        }
    }
}

struct CreateLevelMarkupElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("level-markup-elements")
            .id()
            .field("userID", .uuid, .required, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("level-markup-elements").delete()
    }
}

struct CreatePlanMarkupElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("plan-markup-elements")
            .id()
            .field("userID", .uuid, .required, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("plan-markup-elements").delete()
    }
}
