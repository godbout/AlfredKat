import XCTest
@testable import AlfredKatCore


class AlfredKatTestCase: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        
        mockAlfredWorkflowUID()  
    }
    
    override func setUp() {
        super.setUp()

        Self.resetUserQuery()
        Self.resetEnvironmentVariables()
    }

}


extension AlfredKatTestCase {

    static func spoofUserQuery(with query: String) {
        CommandLine.arguments[1] = query
    }
    
    static func setEnvironmentVariable(name: String, value: String) {
        setenv(name, value, 1)
    }
    
    static func resetEnvironmentVariables() {
        Self.setEnvironmentVariable(name: "action", value: "")
        Self.setEnvironmentVariable(name: "torrent_page_link", value: "")
        Self.setEnvironmentVariable(name: "cli", value: "")
    }
    
    static func resetUserQuery() {
        CommandLine.arguments[1] = ""
    }

}


extension AlfredKatTestCase {
    
    private static func mockAlfredWorkflowUID() {
        Self.setEnvironmentVariable(name: "alfred_workflow_uid", value: "AlfredKat")
    }

}
