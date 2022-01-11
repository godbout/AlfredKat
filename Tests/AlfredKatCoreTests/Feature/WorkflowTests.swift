@testable import AlfredKatCore
import XCTest

class WorkflowTests: AlfredKatTestCase {
    func test_that_it_can_search_for_torrents_on_the_KAT_site() {
        Self.spoofUserQuery(with: "fight club")

        XCTAssertTrue(
            Workflow.menu().contains("Fight Club (1999)")
        )
    }

    func test_that_it_can_filter_torrents_by_music_type() {
        Self.spoofUserQuery(with: "blonde redhead #music")

        XCTAssertTrue(
            Workflow.menu().contains("Blonde Redhead 2007 23")
        )

        XCTAssertFalse(
            Workflow.menu().contains("Porno")
        )
    }

    func test_that_it_tells_the_user_that_there_is_no_item_found_if_well_there_is_no_item_found() {
        Self.spoofUserQuery(with: "lksjdflkasjfdwoivlijssdkfjhsgoiweuh skjhskjhsafdhkjv")

        XCTAssertTrue(
            Workflow.menu().contains("404")
        )
    }

    func test_that_it_can_get_the_torrent_page_link() {
        Self.spoofUserQuery(with: "fight club YIFY")

        XCTAssertTrue(
            Workflow.menu().contains("/fight-club-1999-1080p-brrip-x264-yify-t446902.html")
        )
    }

    func test_that_it_can_download_a_chosen_torrent_through_the_default_application() {
        Self.setEnvironmentVariable(name: "action", value: "download")
        Self.setEnvironmentVariable(
            name: "torrent_page_link",
            value: "/fight-club-1999-1080p-brrip-x264-yify-t446902.html"
        )

        XCTAssertTrue(
            Workflow.do()
        )
    }

    func test_that_it_can_download_a_chosen_torrent_through_a_cli_command() {
        Self.setEnvironmentVariable(name: "action", value: "download")
        Self.setEnvironmentVariable(
            name: "torrent_page_link",
            value: "/fight-club-1999-1080p-brrip-x264-yify-t446902.html"
        )

        Self.setEnvironmentVariable(name: "cli", value: "/usr/bin/open -R {magnet}")

        XCTAssertTrue(
            Workflow.do()
        )
    }

    func test_that_it_can_copy_the_magnet_link_of_a_chosen_torrent() {
        Self.setEnvironmentVariable(name: "action", value: "copy")
        Self.setEnvironmentVariable(
            name: "torrent_page_link",
            value: "/fight-club-1999-1080p-brrip-x264-yify-t446902.html"
        )

        XCTAssertTrue(
            Workflow.do()
        )
    }
}
