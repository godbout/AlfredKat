@testable import AlfredKatCore
import XCTest

class TagsTest: XCTestCase {
    func test_that_it_can_filter_torrents_by_music_type() {
        spoofUserQuery(with: "blonde redhead #music")

        XCTAssertTrue(
            Workflow.menu().contains("Blonde Redhead 2007 23")
        )

        XCTAssertFalse(
            Workflow.menu().contains("Porno")
        )
    }
}
