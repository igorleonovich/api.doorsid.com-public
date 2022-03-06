//@testable import App
//import XCTVapor

//final class DayTests: XCTestCase {
//    
//    let daysURI = "/api/days/"
//    var app: Application!
//    
//    override func setUpWithError() throws {
//        app = try Application.testable()
//    }
//    
//    override func tearDownWithError() throws {
//        app.shutdown()
//    }
//    
//    func testDaysCanBeRetrievedFromAPI() throws {
//        let user = try User.create(on: app.db)
//        let day1 = try Day.create(date: Date(), userID: user.id!, on: app.db)
//        let day2 = try Day.create(userID: user.id!, on: app.db)
//
//      try app.test(.GET, daysURI, afterResponse: { response in
//        XCTAssertEqual(response.status, .ok)
//        let days = try response.content.decode([Day].self)
//        XCTAssertEqual(days.count, 2)
//
//        var calender = Calendar.current
//        calender.timeZone = TimeZone.current
//
//        var result = calender.compare(days[0].date, to: day1.date, toGranularity: .day)
//        var isSameDay = result == .orderedSame
//        XCTAssertTrue(isSameDay)
//        XCTAssertEqual(days[0].id, day1.id)
//
//        result = calender.compare(days[1].date, to: day2.date, toGranularity: .day)
//        isSameDay = result == .orderedSame
//        XCTAssertTrue(isSameDay)
//        XCTAssertEqual(days[1].id, day2.id)
//      })
//    }
//}
