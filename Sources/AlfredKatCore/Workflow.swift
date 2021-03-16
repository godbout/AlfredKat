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
        let action = ProcessInfo.processInfo.environment["action"] ?? ""

        switch action {
        default:
            return false
        }
    }

    public static func notify(resultFrom _: Bool = false) -> String {
        let action = ProcessInfo.processInfo.environment["action"] ?? "huh"

        switch action {
        case "download":
            return "notify download"
        case "copy":
            return "notify copy"
        default:
            return "huh. what did you do?!"
        }
    }
}
