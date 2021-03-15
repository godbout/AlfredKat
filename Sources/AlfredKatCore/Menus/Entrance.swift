import AlfredWorkflowScriptFilter
import Foundation
import SwiftSoup

// TODO: should be a singleton
class Entrance {
    static func userQuery() -> String {
        CommandLine.arguments[1]
    }

    static func scriptFilter() -> String {
        results(for: userQuery())
    }

    static func results(for query: String) -> String {
        do {
            let torrents = try searchOnline(for: query)
            
            return menuFor(torrents: torrents)
        } catch {
            return ScriptFilter.add(Item(title: "can't grab the torrents online for whatever reason")).output()
        }
    }

    static func searchOnline(for query: String) throws -> Elements? {
        let urlString = buildURL(from: query)

        // TODO: handle errors properly
        guard let url = URL(string: urlString) else { return nil }
        let html = try String(contentsOf: url)
        let document = try SwiftSoup.parse(html)
        let torrents = try document.select(".frontPageWidget tr").first()?.siblingElements()

        return torrents
    }

    private static func buildURL(from query: String) -> String {
        let urlBase = ProcessInfo.processInfo.environment["url"] ?? "https://kickasstorrents.to"

        return urlBase + "/search/" + (query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
    }

    private static func menuFor(torrents: Elements?) -> String {
        if let torrents = torrents {
            for torrent in torrents {
                let title = TorrentMenuItemBuilder.title(for: torrent)
                let subtitle = TorrentMenuItemBuilder.subtitle(for: torrent)

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
                Item(title: "404 for \(userQuery()) ☹️")
                    .subtitle("Try some other terms maybe?")
            )
        }

        return ScriptFilter.output()
    }
}
