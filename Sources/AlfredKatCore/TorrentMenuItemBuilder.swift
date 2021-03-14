import SwiftSoup

// TODO: should be a proper singleton. wtf is that thing?
public class TorrentMenuItemBuilder {
    let shared = TorrentMenuItemBuilder()

    private init() {}

    static func title(for row: Element) throws -> String {
        try row.text()
    }

    static func subtitle(for row: Element) throws -> String {
        try row.text()
    }
}
