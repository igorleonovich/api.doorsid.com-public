import Fluent

struct CreateElement: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("elements")
            .id()
            .field("userID", .uuid, .required, .references("users", "id"))
            .field("superElementID", .uuid, .references("elements", "id"))
            .field("markupElementContainerID", .uuid, .references("markup-element-containers", "id"))
            .field("dataElementContainerID", .uuid, .references("data-element-containers", "id"))
            .field("index", .int, .required)
            .field("flipFlag", .bool, .required, .custom("DEFAULT FALSE"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("elements").delete()
    }
}
