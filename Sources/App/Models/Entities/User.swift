import Vapor
import Fluent

enum AuthenticationNameType {
    case email
    case phone
    case username
}

final class User: Model, Authenticatable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @OptionalField(key: "name")
    var name: String?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "is_email_verified")
    var isEmailVerified: Bool
    
    @OptionalField(key: "phone")
    var phone: String?
    
    @Field(key: "is_phone_verified")
    var isPhoneVerified: Bool
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Enum(key: "role")
    var role: Role
    
    @Field(key: "doors_services_active")
    var doorsServicesActive: [DoorsService]
    
    @Field(key: "doors_services_inactive")
    var doorsServicesInactive: [DoorsService]
    
    
    init() {}
    
    init(
        id: UUID? = nil,
        username: String,
        name: String? = nil,
        email: String,
        isEmailVerified: Bool = false,
        phone: String? = nil,
        isPhoneVerified: Bool = false,
        passwordHash: String,
        role: Role = .empty,
        doorsServicesActive: [DoorsService] = [.id],
        doorsServicesInactive: [DoorsService] = [.plan]
    ) {
        self.id = id
        self.username = username
        self.name = name
        self.email = email
        self.isEmailVerified = isEmailVerified
        self.phone = phone
        self.isPhoneVerified = isPhoneVerified
        self.passwordHash = passwordHash
        self.role = role
        self.doorsServicesActive = doorsServicesActive
        self.doorsServicesInactive = doorsServicesInactive
    }
}
