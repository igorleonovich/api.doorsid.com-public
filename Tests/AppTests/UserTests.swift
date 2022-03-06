//@testable import App
//import XCTVapor

//final class UserTests: XCTestCase {
//    
//    let usersUsername = "swiatek"
//    let usersURI = "/api/users/"
//    var app: Application!
//    
//    override func setUpWithError() throws {
//      app = try Application.testable()
//    }
//    
//    override func tearDownWithError() throws {
//      app.shutdown()
//    }
//    
//    func testUsersCanBeRetrievedFromAPI() throws {
//      let user1 = try User.create(username: usersUsername, on: app.db)
//      let user2 = try User.create(on: app.db)
//
//      try app.test(.GET, usersURI, afterResponse: { response in
//        XCTAssertEqual(response.status, .ok)
//        let users = try response.content.decode([User].self)
//        XCTAssertEqual(users.count, 2)
//        XCTAssertEqual(users[0].username, user1.username)
//        XCTAssertEqual(users[0].id, user1.id)
//        XCTAssertEqual(users[1].username, user2.username)
//        XCTAssertEqual(users[1].id, user2.id)
//      })
//    }
//
//    func testUserCanBeSavedWithAPI() throws {
//        let user = User(username: usersUsername)
//
//        try app.test(.POST, usersURI, beforeRequest: { req in
//            try req.content.encode(user)
//        }, afterResponse: { response in
//        let receivedUser = try response.content.decode(User.self)
//
//        XCTAssertEqual(receivedUser.username, usersUsername)
//        XCTAssertNotNil(receivedUser.id)
//
//        try app.test(.GET, usersURI, afterResponse: { secondResponse in
//            let users = try secondResponse.content.decode([User].self)
//            XCTAssertEqual(users.count, 1)
//            XCTAssertEqual(users[0].username, user.username)
//            XCTAssertEqual(users[0].id, receivedUser.id)
//          })
//        })
//    }
//
//    func testGettingASingleUserFromTheAPI() throws {
//        let user = try User.create(username: usersUsername, on: app.db)
//
//        try app.test(.GET, "\(usersURI)\(user.id!)", afterResponse: { response in
//            let receivedUser = try response.content.decode(User.self)
//            XCTAssertEqual(receivedUser.username, user.username)
//            XCTAssertEqual(receivedUser.id, user.id)
//        })
//    }
//}
