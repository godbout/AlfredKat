@testable import AlfredKatCore
import XCTest

class NotificationsTests: AlfredKatTestCase {
    func test_that_it_can_notify_the_user_when_download() {
        Self.setEnvironmentVariable(name: "action", value: "download")
        Self.setEnvironmentVariable(name: "torrent_name", value: "Fight Club (1999) 1080p BrRip x264 - YIFY")

        XCTAssertTrue(
            Workflow.notify().contains("Fight Club (1999) 1080p BrRip x264 - YIFY")
        )
    }

    func test_that_it_can_notify_the_user_when_copy() {
        Self.setEnvironmentVariable(name: "action", value: "download")
        Self.setEnvironmentVariable(name: "torrent_name", value: "Fight Club (1999) 1080p BrRip x264 - YIFY")

        XCTAssertTrue(
            Workflow.notify().contains("Fight Club (1999) 1080p BrRip x264 - YIFY")
        )
    }

    func test_that_the_user_receives_the_correct_notification_when_downloading() {
        Self.setEnvironmentVariable(name: "torrent_name", value: "Fight Club (1999) 1080p BrRip x264 - YIFY")

        Self.setEnvironmentVariable(name: "action", value: "download")
        XCTAssertTrue(
            Workflow.notify().contains("will soon be at home")
        )
    }

    func test_that_the_user_receives_the_correct_notification_when_copying() {
        Self.setEnvironmentVariable(name: "action", value: "copy")
        XCTAssertTrue(
            Workflow.notify().contains("has been copied to clipboard")
        )
    }

    func test_that_the_user_does_not_receive_a_notification_when_updating() {
        Self.setEnvironmentVariable(name: "action", value: "update")
        XCTAssertTrue(
            Workflow.notify().isEmpty
        )
    }

    func test_that_the_user_does_not_receive_a_notification_when_going_to_release_page() {
        Self.setEnvironmentVariable(name: "action", value: "go_release_page")
        XCTAssertTrue(
            Workflow.notify().isEmpty
        )
    }
}
