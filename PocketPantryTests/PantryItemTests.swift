import XCTest
@testable import PocketPantry

final class PantryItemTests: XCTestCase {
    private var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }

    private var referenceDate: Date {
        DateComponents(
            calendar: calendar,
            timeZone: calendar.timeZone,
            year: 2026,
            month: 11,
            day: 10,
            hour: 12
        ).date!
    }

    func testPastDateIsExpired() {
        let item = makeItem(daysFromReference: -1)

        XCTAssertEqual(
            item.expirationStatus(relativeTo: referenceDate, calendar: calendar),
            .expired
        )
    }

    func testTodayThroughThreeDaysIsExpiringSoon() {
        for dayOffset in 0...3 {
            let item = makeItem(daysFromReference: dayOffset)

            XCTAssertEqual(
                item.expirationStatus(relativeTo: referenceDate, calendar: calendar),
                .expiringSoon
            )
        }
    }

    func testDateBeyondWarningWindowIsFresh() {
        let item = makeItem(daysFromReference: 4)

        XCTAssertEqual(
            item.expirationStatus(relativeTo: referenceDate, calendar: calendar),
            .fresh
        )
    }

    func testDaysUntilExpirationUsesCalendarDays() {
        let item = makeItem(daysFromReference: 7)

        XCTAssertEqual(
            item.daysUntilExpiration(relativeTo: referenceDate, calendar: calendar),
            7
        )
    }

    private func makeItem(daysFromReference days: Int) -> PantryItem {
        let expirationDate = calendar.date(byAdding: .day, value: days, to: referenceDate)!
        return PantryItem(
            name: "Test item",
            category: .other,
            quantity: 1,
            expirationDate: expirationDate
        )
    }
}
