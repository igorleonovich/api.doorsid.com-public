import Fluent


struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        return database.enum("doors_service")
            .case("id")
            .case("plan")
            .case("bank")
            .case("engine")
            .case("teker")
            .create()
            .flatMap { _ in
                return database.enum("role")
                    .case("empty")
                    .case("guest")
                    .case("use")
                    .case("test")
                    .case("dev")
                    .case("publish")
                    .case("admin")
                    .create()
                    .flatMap { role in
                        return database.schema("users")
                            .id()
                            .field("username", .string, .required)
                            .field("email", .string, .required)
                            .field("is_email_verified", .bool, .required, .custom("DEFAULT FALSE"))
                            .field("phone", .string)
                            .field("is_phone_verified", .bool, .required, .custom("DEFAULT FALSE"))
                            .field("password_hash", .string, .required)
                            .field("role", role, .required, .custom("DEFAULT 'empty'"))
                            .unique(on: "email")
                            .unique(on: "phone")
                            .unique(on: "username")
                            .field("name", .string)
                            .field("doors_services_active", .sql(raw: "text[]"), .required, .custom("DEFAULT ARRAY['id']"))
                            .field("doors_services_inactive", .sql(raw: "text[]"), .required, .custom("DEFAULT ARRAY['plan','bank','engine','teker']"))
                            .create()
                    }
            }
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users").delete().flatMap {
            return database.enum("role").delete().flatMap {
                return database.enum("doors_service").delete()
            }
        }
    }
}
