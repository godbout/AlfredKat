import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(AlfredKatTests.allTests),
        ]
    }
#endif
