import SwiftSoup

public class TorrentMenuItemBuilder {
    static let shared = TorrentMenuItemBuilder()

    private init() {}

    static func title(for row: Element) -> String {
        do {
            let size = try row.child(1).text()
            let uploader = try row.child(2).text()
            let when = try row.child(3).text() + " ago"
            let seeders = try row.child(4).text()
            let leechers = try row.child(5).text()


            return "\(when) by \(uploader), \(size), \(seeders) seeders (\(leechers) l)"

        } catch {
            return "can't make up the title for that torrent item huh 😕️"
        }
    }

    static func subtitle(for row: Element) -> String {
        do {
            return try row.text().components(separatedBy: " Posted by").first ?? "torrent description missing 😨️"
        } catch {
            return "can't make up the subtitle for that torrent item huh 😣️"
        }
    }
}
