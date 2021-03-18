@testable import AlfredKatCore
import XCTest

class WorkflowUnitTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        
        Self.setEnvironmentVariable(name: "action", value: "LOOOOOLLLLLL")
    }
}

extension WorkflowUnitTests {
    func test_that_calling_a_workflow_action_that_does_not_exist_returns_false() {
        XCTAssertFalse(
            Workflow.do()
        )
    }

    func test_thatcalling_a_workflow_action_that_does_not_exists_sends_a_notification_that_huh_you_wrong() {
        XCTAssertTrue(
            Workflow.notify().contains("huh.")
        )
    }
}
