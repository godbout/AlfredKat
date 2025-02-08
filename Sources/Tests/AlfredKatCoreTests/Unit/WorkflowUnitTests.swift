@testable import AlfredKatCore
import XCTest

class WorkflowUnitTests: AlfredKatTestCase {
    func test_that_calling_a_workflow_action_that_does_not_exist_returns_false() {
        Self.setEnvironmentVariable(name: "action", value: "LOOOOOLLLLLL")

        XCTAssertFalse(
            Workflow.do()
        )
    }

    func test_that_calling_a_workflow_action_that_does_not_exists_does_not_send_a_notification() {
        Self.setEnvironmentVariable(name: "action", value: "LOOOOOLLLLLL")

        XCTAssertEqual(Workflow.notify(), "")
    }
}
