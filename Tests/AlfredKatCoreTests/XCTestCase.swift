import XCTest

extension XCTestCase {
    func spoofUserQuery(with query: String) {
        CommandLine.arguments[1] = query
    }
}
