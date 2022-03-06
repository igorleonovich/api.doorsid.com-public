import Vapor

struct UserPrivateDTO: Content {
    
    let id: UUID?
    let username: String
    let name: String?
    let email: String
    let isEmailVerified: Bool
    let phone: String?
    let isPhoneVerified: Bool
    let role: Role
    let doorsServicesActive: [DoorsService]
    let doorsServicesInactive: [DoorsService]
    
    init(id: UUID? = nil, username: String, name: String? = nil, email: String, isEmailVerified: Bool, phone: String? = nil,
         isPhoneVerified: Bool, role: Role, doorsServicesActive: [DoorsService], doorsServicesInactive: [DoorsService]) {
        self.id = id
        self.username = username
        self.name = name
        self.email = email
        self.isEmailVerified = isEmailVerified
        self.phone = phone
        self.isPhoneVerified = isPhoneVerified
        self.role = role
        self.doorsServicesActive = doorsServicesActive
        self.doorsServicesInactive = doorsServicesInactive
    }
    
    init(from user: User) {
        self.init(
            id: user.id,
            username: user.username,
            name: user.name,
            email: user.email,
            isEmailVerified: user.isEmailVerified,
            phone: user.phone,
            isPhoneVerified: user.isPhoneVerified,
            role: user.role,
            doorsServicesActive: user.doorsServicesActive,
            doorsServicesInactive: user.doorsServicesInactive
        )
    }
}


struct UserPublicDTO: Content {
    
    let id: UUID?
    let username: String
    let role: Role
    
    init(id: UUID? = nil, username: String, role: Role) {
        self.id = id
        self.username = username
        self.role = role
    }
    
    init(from user: User) {
        self.init(id: user.id, username: user.username, role: user.role)
    }
}
