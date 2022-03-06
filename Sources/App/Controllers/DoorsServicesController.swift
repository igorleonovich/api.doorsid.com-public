//
//  DoorsServicesController.swift
//  
//
//  Created by Igor Leonovich on 24.06.21
//  Copyright © 2021 FT. All rights reserved.
//

import Fluent
import Vapor

struct DoorsServicesController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        // Authentication required
        let doorsServices = routes.grouped("doors-services")
        doorsServices.group(UserAuthenticator()) { authenticated in
            authenticated.put(":doorsService", "activate", use: activateDoorsServcieHandler)
        }
    }
    
    func activateDoorsServcieHandler(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let payload = try req.auth.require(Payload.self)
        
        return req.users
            .find(id: payload.userID)
            .unwrap(or: AuthenticationError.userNotFound)
            .flatMap { user in
                
                
                
                if let doorsServiceString = req.parameters.get("doorsService"),
                   let doorsService = DoorsService(rawValue: doorsServiceString),
                   let index = user.doorsServicesInactive.firstIndex(of: doorsService) {
                    user.doorsServicesInactive.remove(at: index)
                    user.doorsServicesActive.append(doorsService)
                    return user.save(on: req.db).transform(to: .noContent)
                } else {
                    return req.eventLoop.makeFailedFuture(Abort(.badRequest))
                }
            }
    }
}
