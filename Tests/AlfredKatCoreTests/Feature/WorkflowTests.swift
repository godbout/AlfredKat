@testable import AlfredKatCore
import XCTest

class WorkflowTests: XCTestCase {
    func spoofUserQuery(with query: String) {
        CommandLine.arguments[1] = query
    }

    func test_that_it_can_search_for_torrents_on_the_KAT_site() {
        spoofUserQuery(with: "fight club")

        XCTAssertTrue(
            try Workflow.menu().contains("Fight Club (1999)")
        )
    }

    func test_that_it_tells_the_user_that_there_is_no_item_found_if_well_there_is_no_item_found() {
        spoofUserQuery(with: "lksjdflkasjfdwoivlijssdkfjhsgoiweuh skjhskjhsafdhkjv")

        XCTAssertTrue(
            try Workflow.menu().contains("404")
        )
    }

    func test_that_calling_a_workflow_action_that_does_not_exist_returns_false() {
        Process().environment = ["action": "LOOOOOLLLLLL"]

        XCTAssertFalse(Workflow.do())
    }
}
