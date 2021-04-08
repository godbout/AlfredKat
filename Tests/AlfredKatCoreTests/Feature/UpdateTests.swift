@testable import AlfredKatCore
import XCTest

class UpdateTests: AlfredKatTestCase {
    func test_that_Alfred_Kat_can_detect_an_available_self_update() {
        Self.spoofUserQuery(with: "fight club")
        Self.mockLocalWorkflowFolder()

        XCTAssertTrue(
            Workflow.menu().contains("update available!")
        )
    }

    func test_that_Alfred_Kat_can_download_its_own_update() {
        Self.setEnvironmentVariable(
            name: "workflow_file_url",
            value: "https://github.com/godbout/AlfredKat/releases/download/6.0.1/KAT.alfredworkflow"
        )
        Self.setEnvironmentVariable(name: "action", value: "update")

        XCTAssertTrue(
            Workflow.do()
        )
    }
}
