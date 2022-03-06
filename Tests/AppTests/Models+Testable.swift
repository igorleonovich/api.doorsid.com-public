//@testable import App
//import Foundation
//import Fluent

//extension User {
//  static func create(username: String = "ileonovich", on database: Database) throws -> User {
//    let user = User(username: username)
//    try user.save(on: database).wait()
//    return user
//  }
//}

//extension Day {
//    static func create(date: Date = Date(), userID: UUID = UUID(), on database: Database) throws -> Day {
//        let day = Day(date: date, userID: userID)
//        try day.save(on: database).wait()
//        return day
//    }
//}
