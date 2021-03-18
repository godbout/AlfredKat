import XCTest

extension XCTestCase {
    override open func setUp() {
        Self.resetUserQuery()
        Self.resetEnvironmentVariables()
    }
}

extension XCTestCase {
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
