import Vapor

struct RegisterRequest: Content {
    let username: String
    let email: String
    let password: String
    let confirmPassword: String
}

extension RegisterRequest: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: .count(2...))
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(3...))
    }
}

extension User {
    convenience init(from register: RegisterRequest, hash: String) throws {
        self.init(username: register.username, email: register.email, passwordHash: hash)
    }
}
