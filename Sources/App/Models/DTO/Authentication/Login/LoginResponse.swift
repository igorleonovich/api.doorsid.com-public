import Vapor

struct LoginResponse: Content {
    let user: UserPrivateDTO
    let accessToken: String
    let refreshToken: String
}
