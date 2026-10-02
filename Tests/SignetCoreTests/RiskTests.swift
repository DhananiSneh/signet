import XCTest
@testable import SignetCore

final class RiskTests: XCTestCase {
    func testPasscodeRequestIsHighRisk() {
        let call = CallFacts(caller: "Account Security", spoofed: true, asksForPasscode: true, knownContact: false)
        XCTAssertEqual(Signet.assess(call), .high)
        XCTAssertEqual(Signet.headline(for: .high), "Incoming · High risk")
        XCTAssertEqual(Signet.guidance(for: call), "A real bank does not call to ask for a passcode.")
    }

    func testKnownContactIsLowRisk() {
        let call = CallFacts(caller: "A. Shah", spoofed: false, asksForPasscode: false, knownContact: true)
        XCTAssertEqual(Signet.assess(call), .low)
        XCTAssertEqual(Signet.guidance(for: call), "This number is already in your contacts.")
    }

    func testUnknownCallerIsWatched() {
        let call = CallFacts(caller: "Unknown", spoofed: false, asksForPasscode: false, knownContact: false)
        XCTAssertEqual(Signet.assess(call), .watch)
    }
}
