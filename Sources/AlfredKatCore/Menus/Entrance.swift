import AlfredWorkflowScriptFilter
import Foundation
import SwiftSoup

// TODO: should be a singleton
class Entrance {
    static func userQuery() -> String {
        CommandLine.arguments[1]
    }

    static func scriptFilter() throws -> String {
        try torrentResults(for: Workflow.userQuery())
    }

    static func torrentResults(for query: String) throws -> String {
        let torrents = searchOnline(for: query)

        return menuFor(torrents: torrents)
    }

    private static func searchOnline(for query: String) -> Elements? {
        let urlString = buildURL(from: query)

        // TODO: handle errors properly
        guard let url = URL(string: urlString) else { return nil }
        let html = try! String(contentsOf: url)
        let document = try! SwiftSoup.parse(html)
        let torrents = try! document.select(".frontPageWidget tr").first()?.siblingElements()

        return torrents
    }

    private static func buildURL(from query: String) -> String {
        let urlBase = ProcessInfo.processInfo.environment["url"] ?? "https://kickasstorrents.to"

        return urlBase + "/search/" + (query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
    }

    private static func menuFor(torrents: Elements?) -> String {
        if let torrents = torrents {
            for torrent in torrents {
                let title = try! TorrentMenuItemBuilder.title(for: torrent)
                let subtitle = try! TorrentMenuItemBuilder.subtitle(for: torrent)

                ScriptFilter.add(
                    Item(title: title)
                        .subtitle(subtitle)
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
                Item(title: "404 for \(Workflow.userQuery()) ☹️")
                    .subtitle("Try some other terms maybe?")
            )
        }

        return ScriptFilter.output()
    }
}
