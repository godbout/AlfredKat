import AlfredWorkflowScriptFilter
import Foundation
import SwiftSoup

public enum Workflow {
    public static func userQuery() -> String {
        CommandLine.arguments[1]
    }

    public static func next() -> String {
        ProcessInfo.processInfo.environment["next"] ?? "oops"
    }

    static func torrentResults(for query: String) throws -> String {
        let urlString = "https://kickasstorrents.to/usearch/" + (query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")

        guard let url = URL(string: urlString) else { exit(1) }
        let html = try String(contentsOf: url)
        let document = try SwiftSoup.parse(html)
        let torrents = try document.select(".frontPageWidget tr").first()?.siblingElements()

        if let torrents = torrents {
            for torrent in torrents {
                ScriptFilter.add(
                    Item(title: try torrent.text())
                        .subtitle(try torrent.text())
                        .arg("do")
                        .variable(Variable(name: "action", value: "download"))
                        .mod(
                            Cmd()
                                .arg("do")
                                .subtitle("Copy magnet link")
                                .variable(Variable(name: "action", value: "copy"))
                        )
                )
            }
        } else {
            ScriptFilter.add(
                Item(title: "404 for \(query) ☹️")
                    .subtitle("Try some other terms maybe?")
            )
        }

        return ScriptFilter.output()
    }

    public static func menu() throws -> String {
        try torrentResults(for: userQuery())
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
