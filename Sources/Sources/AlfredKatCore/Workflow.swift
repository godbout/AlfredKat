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
        let action = ProcessInfo.processInfo.environment["action"]
        let torrentPageLink = ProcessInfo.processInfo.environment["torrent_page_link"] ?? ""

        switch action {
        case "download":
            return download(using: torrentPageLink)
        case "copy":
            return copy(using: torrentPageLink)
        default:
            return false
        }
    }

    public static func notify(resultFrom _: Bool = false) -> String {
        let action = ProcessInfo.processInfo.environment["action"]
        let torrentName = ProcessInfo.processInfo.environment["torrent_name"] ?? "some porn"

        switch action {
        case "download":
            return notificationOfDownload(for: torrentName)
        case "copy":
            return notificationOfCopy(for: torrentName)
        case "update":
            return ""
        case "go_release_page":
            return ""
        default:
            return ""
        }
    }

}


extension Workflow {
    
    public static func setURLCache() {
        if let alfredWorkflowCache = ProcessInfo.processInfo.environment["alfred_workflow_cache"] {
            try? FileManager.default.createDirectory(atPath: alfredWorkflowCache, withIntermediateDirectories: false)
            // URLCache diskPath is deprecated, but Apple doesn't seem to have a replacement yet.
            // if using directory, we can't get a URL working with "Workflow Data" because of the space. we can
            // get a functioning URL with fileURLWithPath but once we pass it to URLCache, it will create a
            // "Workflow%20Data" folder. same with using the new FilePath. currently it doesn't seem there's
            // a replacement, hence using diskPath until it's fully removed by Apple, which will surely have provided
            // a solution by then.
            URLCache.shared = URLCache(memoryCapacity: 1_000_000, diskCapacity: 10_000_000, diskPath: alfredWorkflowCache)
        } else {
            URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, directory: nil)
        }
    }
    
    private static func download(using torrentPageLink: String) -> Bool {
        guard let magnetLink = findMagnetLink(on: torrentPageLink) else {
            return false
        }

        if (ProcessInfo.processInfo.environment["cli"] ?? "") != "" {
            return useCLIToDownload(torrent: magnetLink)
        }

        return useDefaultApplicationToDownload(torrent: magnetLink)
    }

    private static func findMagnetLink(on torrentPageLink: String) -> String? {
        let urlBase = ProcessInfo.processInfo.environment["url"] ?? "https://kickasstorrents.to"

        guard let url = URL(string: urlBase + torrentPageLink) else { return nil }

        var magnetLink: String

        do {
            let html = try String(contentsOf: url)
            let document = try SwiftSoup.parse(html)
            magnetLink = try document.select("#tab-technical a.siteButton.giantButton").attr("href")
        } catch {
            return nil
        }

        return magnetLink
    }

    private static func useCLIToDownload(torrent magnetLink: String) -> Bool {
        let fullDummyCommand = ProcessInfo.processInfo.environment["cli"] ?? ""
        let fullRealCommand = fullDummyCommand.replacingOccurrences(of: "{magnet}", with: magnetLink)

        var arguments = fullRealCommand.split(separator: " ").map { String($0) }

        guard arguments.count != 0 else { return false }

        let tool = arguments.removeFirst()

        let task = Process()

        task.executableURL = URL(fileURLWithPath: String(tool))
        task.arguments = arguments

        do {
            try task.run()
        } catch {
            return false
        }

        return true
    }

    private static func useDefaultApplicationToDownload(torrent magnetLink: String) -> Bool {
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

    private static func copy(using torrentPageLink: String) -> Bool {
        guard let magnetLink = findMagnetLink(on: torrentPageLink) else {
            return false
        }

        let pipe = Pipe()

        let echo = Process()
        echo.executableURL = URL(fileURLWithPath: "/bin/echo")
        echo.arguments = [magnetLink]
        echo.standardOutput = pipe

        let pbcopy = Process()
        pbcopy.executableURL = URL(fileURLWithPath: "/usr/bin/pbcopy")
        pbcopy.standardInput = pipe

        do {
            try echo.run()
            try pbcopy.run()
        } catch {
            return false
        }

        return true
    
    }
    
    private static func notificationOfDownload(for torrentName: String) -> String {
        "\(torrentName) will soon be at home!"
    }

    private static func notificationOfCopy(for torrentName: String) -> String {
        let lowerBound = torrentName.index(torrentName.startIndex, offsetBy: 0)
        let higherBound = torrentName.index(torrentName.startIndex, offsetBy: 30)

        let name = torrentName[lowerBound ... higherBound]

        return "Magnet link for \(name)... has been copied to clipboard!"
    }
    
}
