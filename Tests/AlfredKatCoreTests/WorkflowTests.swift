import XCTest
@testable import AlfredKatCore

class WorkflowTests: XCTestCase {
    private let process = Process()
    
    override func setUp() {
        process.environment = ["action": "LOOOOOOOOLLLL"]
        
        super.setUp()
    }
}

extension WorkflowTests {
    func test_that_calling_a_workflow_action_that_does_not_exist_returns_false() {
        XCTAssertFalse(Workflow.do())
    }
    
    func test_that_calling_a_workflow_action_that_does_not_exists_sends_a_notification_that_huh_you_wrong() {
        XCTAssertEqual(
            "huh.", Workflow.notify()
        )
    }
}
