import XCTest

extension XCTestCase {
    static func spoofUserQuery(with query: String) {
        CommandLine.arguments[1] = query
    }

    static func setEnvironmentVariable(name: String, value: String) {
        setenv(name, value, 1)
    }
}
