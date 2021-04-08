import AlfredWorkflowScriptFilter
import AlfredWorkflowUpdater
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
        if let release = Updater.checkUpdate(for: "godbout/AlfredKat") {
            ScriptFilter.add(
                Item(title: "update available! (\(release.version))")
                    .subtitle("press Enter to update, or Command Enter to take a trip to the release page")
                    .arg("do")
                    .variable(Variable(name: "action", value: "update"))
                    .variable(Variable(name: "workflow_file_url", value: release.file))
                    .mod(
                        Cmd()
                            .subtitle("say hello to the release page")
                            .arg("do")
                            .variables(
                                Variable(name: "action", value: "go_release_page"),
                                Variable(name: "release_page_url", value: release.page)
                            )
                    )
            )
        }

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
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""

        if encodedQuery.contains("%23") {
            let term = encodedQuery.components(separatedBy: "%23")[0]
            let tag = encodedQuery.components(separatedBy: "%23")[1]

            return urlBase + "/search/" + term + "/category/" + tag
        }

        return urlBase + "/search/" + encodedQuery
    }

    private static func menuFor(torrents: Elements?) -> String {
        if let torrents = torrents {
            for torrent in torrents {
                let title = TorrentMenuItemBuilder.title(for: torrent)
                let subtitle = TorrentMenuItemBuilder.subtitle(for: torrent)
                let torrentPageLink = TorrentMenuItemBuilder.pageLink(for: torrent)

                ScriptFilter.add(
                    Item(title: title)
                        .subtitle(subtitle)
                        .arg("do")
                        .variable(Variable(name: "action", value: "download"))
                        .variable(Variable(name: "torrent_page_link", value: torrentPageLink))
                        .variable(Variable(name: "torrent_name", value: subtitle))
                        .icon(
                            Icon(path: "Resources/magnet.png")
                        )
                        .mod(
                            Cmd()
                                .arg("do")
                                .subtitle("copy magnet link")
                                .variable(Variable(name: "action", value: "copy"))
                                .variable(Variable(name: "torrent_page_link", value: torrentPageLink))
                                .variable(Variable(name: "torrent_name", value: subtitle))
                        )
                )
            }
        } else {
            ScriptFilter.add(
                Item(title: "404 for \(userQuery()) ☹️")
                    .subtitle("try some other terms maybe?")
            )
        }

        return ScriptFilter.output()
    }
}
