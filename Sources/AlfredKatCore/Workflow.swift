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
        let torrentPageLink = ProcessInfo.processInfo.environment["torrent_page_link"] ?? ""

        switch action {
        case "download":
            return download(using: torrentPageLink)
        default:
            return false
        }
    }

    private static func download(using torrentPageLink: String) -> Bool {
        let urlBase = ProcessInfo.processInfo.environment["url"] ?? "https://kickasstorrents.to"
        var html = ""
        var document: Document
        var magnetLink: String

        guard let url = URL(string: urlBase + torrentPageLink) else { return false }

        do {
            html = try String(contentsOf: url)
        } catch {
            return false
        }

        do {
            document = try SwiftSoup.parse(html)
        } catch {
            return false
        }

        do {
            magnetLink = try document.select("#tab-technical a.siteButton.giantButton").attr("href")
        } catch {
            return false
        }

        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/open")
        task.arguments = [magnetLink]

        do {
            try task.run()
        } catch {
            return false
        }

        return true
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
