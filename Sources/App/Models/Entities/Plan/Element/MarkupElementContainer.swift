//
//  MarkupElementContainer.swift
//  
//
//  Created by Igor Leonovich on 26.07.21
//  Copyright © 2021 FT. All rights reserved.
//

import Vapor
import Fluent

final class MarkupElementContainer: Model, Codable {
  
    static let schema = "markup-element-containers"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @OptionalParent(key: "markupElementAlias")
    var markupElementAlias: MarkupElementAlias?
    
    @OptionalParent(key: "markupElement")
    var markupElement: MarkupElement?

    init() {}

    init(id: UUID? = nil, userID: User.IDValue, markupElementAliasID: MarkupElementAlias.IDValue? = nil, markupElementID: MarkupElement.IDValue? = nil) {
        self.id = id
        self.$user.id = userID
        self.$markupElementAlias.id = markupElementAliasID
        self.$markupElement.id = markupElementID
    }
}

final class MarkupElementAlias: Model, Codable {
    
    static let schema = "markup-element-aliases"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @Parent(key: "markupElementID")
    var markupElement: MarkupElement
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue, markupElementID: MarkupElement.IDValue) {
        self.id = id
        self.$user.id = userID
        self.$markupElement.id = markupElementID
    }
}

final class MarkupElement: Model, Codable {
    
    static let schema = "markup-elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @Field(key: "type")
    var type: MarkupElementType
    
    @OptionalParent(key: "orderedUnorderedMarkupElement")
    var orderedUnorderedMarkupElement: OrderedUnorderedMarkupElement?
    
    @OptionalParent(key: "actionsPointsMarkupElement")
    var actionsPointsMarkupElement: ActionsPointsMarkupElement?
    
    @OptionalParent(key: "dateMarkupElement")
    var dateMarkupElement: DateMarkupElement?
    
    @OptionalParent(key: "byTimeMarkupElement")
    var byTimeMarkupElement: ByTimeMarkupElement?
    
    @OptionalParent(key: "byTopicMarkupElement")
    var byTopicMarkupElement: ByTopicMarkupElement?
    
    @OptionalParent(key: "byXMarkupElement")
    var byXMarkupElement: ByXMarkupElement?
    
    @OptionalParent(key: "levelMarkupElement")
    var levelMarkupElement: LevelMarkupElement?
    
    @OptionalParent(key: "planMarkupElement")
    var planMarkupElement: PlanMarkupElement?
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue, type: MarkupElementType, orderedUnorderedMarkupElementID: OrderedUnorderedMarkupElement.IDValue? = nil, actionsPointsMarkupElementID: ActionsPointsMarkupElement.IDValue? = nil, dateMarkupElementID: DateMarkupElement.IDValue? = nil, byTimeMarkupElementID: ByTimeMarkupElement.IDValue? = nil, byTopicMarkupElementID: ByTopicMarkupElement.IDValue? = nil, byXMarkupElementID: ByXMarkupElement.IDValue? = nil, levelMarkupElementID: LevelMarkupElement.IDValue? = nil, planMarkupElementID: PlanMarkupElement.IDValue? = nil) {
        self.id = id
        self.$user.id = userID
        self.type = type
        self.$orderedUnorderedMarkupElement.id = orderedUnorderedMarkupElementID
        self.$actionsPointsMarkupElement.id = actionsPointsMarkupElementID
        self.$dateMarkupElement.id = dateMarkupElementID
        self.$byTimeMarkupElement.id = byTimeMarkupElementID
        self.$byTopicMarkupElement.id = byTopicMarkupElementID
        self.$byXMarkupElement.id = byXMarkupElementID
        self.$levelMarkupElement.id = levelMarkupElementID
        self.$planMarkupElement.id = planMarkupElementID
    }
}

enum MarkupElementType: String, Codable {
    case orderedUnordered, pointAction, date, byTime, byTopic, byX, level, plan
}

final class OrderedUnorderedMarkupElement: Model, Codable {
    
    static let schema = "ordered-unordered-markup-elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @Field(key: "option")
    var type: OrderedUnorderedMarkupElementType
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue, option: OrderedUnorderedMarkupElementType) {
        self.id = id
        self.$user.id = userID
        self.type = type
    }
}

enum OrderedUnorderedMarkupElementType: String, Codable {
    case ordered, unordered
}

final class ActionsPointsMarkupElement: Model, Codable {
    
    static let schema = "actions-points-markup-elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @Field(key: "type")
    var type: ActionsPointsMarkupElementType
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue, type: ActionsPointsMarkupElementType) {
        self.id = id
        self.$user.id = userID
        self.type = type
    }
}

enum ActionsPointsMarkupElementType: String, Codable {
    case actions, points
}

final class DateMarkupElement: Model, Codable {
    
    static let schema = "date-markup-elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @Field(key: "date")
    var date: Date
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue, date: Date) {
        self.id = id
        self.$user.id = userID
        self.date = date
    }
}

final class ByTimeMarkupElement: Model, Codable {
    
    static let schema = "by-time-markup-elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @Field(key: "type")
    var type: ByTimeMarkupElementType
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue, type: ByTimeMarkupElementType) {
        self.id = id
        self.$user.id = userID
        self.type = type
    }
}

enum ByTimeMarkupElementType: String, Codable {
    case before, now, next
}

final class ByTopicMarkupElement: Model, Codable {
    
    static let schema = "by-topic-markup-elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @Field(key: "topic")
    var topic: String
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue, topic: String) {
        self.id = id
        self.$user.id = userID
        self.topic = topic
    }
}

final class ByXMarkupElement: Model, Codable {
    
    static let schema = "by-x-markup-elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    @Field(key: "type")
    var type: ByXMarkupElementType
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue, type: ByXMarkupElementType) {
        self.id = id
        self.$user.id = userID
        self.type = type
    }
}

enum ByXMarkupElementType: String, Codable {
    case time, topic
}

final class LevelMarkupElement: Model, Codable {
    
    static let schema = "level-markup-elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue) {
        self.id = id
        self.$user.id = userID
    }
}

final class PlanMarkupElement: Model, Codable {
    
    static let schema = "plan-markup-elements"

    @ID
    var id: UUID?
    
    @Parent(key: "userID")
    var user: User
    
    init() {}

    init(id: UUID? = nil, userID: User.IDValue) {
        self.id = id
        self.$user.id = userID
    }
}
