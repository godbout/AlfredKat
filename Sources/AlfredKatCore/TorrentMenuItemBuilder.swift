import SwiftSoup

public class TorrentMenuItemBuilder {
    static let shared = TorrentMenuItemBuilder()

    private init() {}

    static func title(for row: Element) -> String {
        do {
            return try row.text()
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
