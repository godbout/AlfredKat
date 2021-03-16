import AlfredWorkflowScriptFilter
import Foundation
import SwiftSoup

enum WorkflowError: Error {
    case noNetwork
    case badURL
    case badHTML
    case badCSSSelector
}

public enum Workflow {
    public static func next() -> String {
        ProcessInfo.processInfo.environment["next"] ?? "oops"
    }

    public static func menu() -> String {
        Entrance.scriptFilter()
    }

    public static func `do`() -> Bool {
        false
    }

    public static func notify(resultFrom result: Bool = false) -> String {
        let action = ProcessInfo.processInfo.environment["action"] ?? "huh"

        if result == false {
            return "oops... cannot \(action)."
        }

        return "\(action) is done!"
    }
}
