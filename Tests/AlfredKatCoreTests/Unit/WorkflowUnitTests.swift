@testable import AlfredKatCore
import XCTest

class WorkflowUnitTests: AlfredKatTestCase {
    func test_that_calling_a_workflow_action_that_does_not_exist_returns_false() {
        Self.setEnvironmentVariable(name: "action", value: "LOOOOOLLLLLL")

        XCTAssertFalse(
            Workflow.do()
        )
    }

    func test_thatcalling_a_workflow_action_that_does_not_exists_sends_a_notification_that_huh_you_wrong() {
        Self.setEnvironmentVariable(name: "action", value: "LOOOOOLLLLLL")

        XCTAssertTrue(
            Workflow.notify().contains("huh.")
        )
    }
}
