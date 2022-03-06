import Fluent
import Vapor

struct UsersController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        // Authentication required
        let usersGroup = routes.grouped("users")
        usersGroup.group(UserAuthenticator()) { authenticated in
            authenticated.get(use: getAllHandler)
            authenticated.get(":userID", use: getByIdHandler)
        }
        
        usersGroup.group(UserAuthenticator()) { authenticated in
            authenticated.get("me", use: getCurrentUser)
        }
    }
    
    private func getAllHandler(_ req: Request) throws -> EventLoopFuture<[UserPublicDTO]> {
        return User.query(on: req.db).all().flatMap { users -> EventLoopFuture<[UserPublicDTO]> in
            let newUsers = users.map { fullUser -> UserPublicDTO in
                return UserPublicDTO(from: fullUser)
            }
            let future: EventLoopFuture<[UserPublicDTO]> = req.eventLoop.makeSucceededFuture(newUsers)
            return future
        }
    }
    
    private func getByIdHandler(_ req: Request) throws -> EventLoopFuture<UserPublicDTO> {
        return User.query(on: req.db).first().flatMap { user -> EventLoopFuture<UserPublicDTO> in
            let newUser = user.map { fullUser -> UserPublicDTO in
                return UserPublicDTO(from: fullUser)
            }
            if let newUser = newUser {
                let succeededFuture: EventLoopFuture<UserPublicDTO> = req.eventLoop.makeSucceededFuture(newUser)
                return succeededFuture
            } else {
                let failedFuture: EventLoopFuture<UserPublicDTO> = req.eventLoop.makeFailedFuture(Abort(.notFound))
                return failedFuture
            }
        }
    }
    
    private func getCurrentUser(_ req: Request) throws -> EventLoopFuture<UserPrivateDTO> {
        let payload = try req.auth.require(Payload.self)
        
        return req.users
            .find(id: payload.userID)
            .unwrap(or: AuthenticationError.userNotFound)
            .map { UserPrivateDTO(from: $0) }
    }
}
