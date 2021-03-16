import AlfredWorkflowScriptFilter
import Foundation
import SwiftSoup

class Entrance {
    static let shared = Entrance()

    private init() {}

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
        } catch WorkflowError.badURL {
            return ScriptFilter.add(Item(title: "can't reach the URL. bad naughty one? 👠️👠️👠️ or blocked? ❌️❌️❌️").subtitle("also check your Internet connection 🙄️")).output()
        } catch WorkflowError.badHTML {
            return ScriptFilter.add(Item(title: "the page HTML is rotten. how the fuck did this happen? ⁉️")).output()
        } catch WorkflowError.badCSSSelector {
            return ScriptFilter.add(Item(title: "can't find the torrents on the site, sorry ah 😑️")).output()
        } catch {
            return ScriptFilter.add(Item(title: "you've reached the end of why the Workflow doesn't work. i don't seem to know 👀️")).output()
        }
    }

    static func searchOnline(for query: String) throws -> Elements? {
        let urlString = buildURL(from: query)
        var html = ""
        var document: Document
        var torrents: Elements?

        guard let url = URL(string: urlString) else { return nil }

        do {
            html = try String(contentsOf: url)
        } catch {
            throw WorkflowError.badURL
        }

        do {
            document = try SwiftSoup.parse(html)
        } catch {
            throw WorkflowError.badHTML
        }

        do {
            torrents = try document.select(".frontPageWidget tr").first()?.siblingElements()
        } catch {
            throw WorkflowError.badCSSSelector
        }

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
