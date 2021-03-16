@testable import AlfredKatCore
import XCTest

class WorkflowTests: XCTestCase {
    func test_that_it_can_search_for_torrents_on_the_KAT_site() {
        spoofUserQuery(with: "fight club")

        XCTAssertTrue(
            Workflow.menu().contains("Fight Club (1999)")
        )
    }

    func test_that_it_tells_the_user_that_there_is_no_item_found_if_well_there_is_no_item_found() {
        spoofUserQuery(with: "lksjdflkasjfdwoivlijssdkfjhsgoiweuh skjhskjhsafdhkjv")

        XCTAssertTrue(
            Workflow.menu().contains("404")
        )
    }

    func test_that_it_can_get_the_torrent_page_link() {
        spoofUserQuery(with: "fight club")

        XCTAssertTrue(
            Workflow.menu().contains("/fight-club-1999-1080p-brrip-x264-yify-t446902.html")
        )
    }

//    func test_that_calling_a_workflow_action_that_does_not_exist_returns_false() {
//        Process().environment = ["action": "LOOOOOLLLLLL"]
//
//        XCTAssertFalse(Workflow.do())
//    }

//    func test_that_it_can_get_the_torrent_page_link() {
//        spoofUserQuery(with: "fight club")
//
//        XCTAssertTrue(
//            try Workflow.menu().contains("/fight-club-1999-1080p-brrip-x264-yify-t446902.html")
//        )
//    }
}
