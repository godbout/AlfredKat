import AlfredKatCore
import SwiftSoup
import XCTest

@testable import AlfredKatCore

class TorrentMenuItemBuilderTests: XCTestCase {
    var row: Element?

    override func setUp() {
        // TODO: absolutely refactor this disgusting shit below
        let query = "ponyo"

        spoofUserQuery(with: query)
        let urlBase = ProcessInfo.processInfo.environment["url"] ?? "https://kickasstorrents.to"
        let urlString = urlBase + "/search/" + (query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")

        guard let url = URL(string: urlString) else { exit(1) }
        let html = try! String(contentsOf: url)
        let document = try! SwiftSoup.parse(html)
        row = try! document.select(".frontPageWidget tr").first()?.siblingElements().first()
    }
}

extension TorrentMenuItemBuilderTests {
//    func test_that_it_can_build_the_item_title() throws {
//        XCTAssertTrue(
//            try TorrentMenuItemBuilder.title(for: row!).contains("ago by YTSAGx, 1.7 GB")
//        )
//    }

    func test_that_it_can_build_the_item_subtitle() throws {
        XCTAssertTrue(
            try TorrentMenuItemBuilder.subtitle(for: row!).contains("Ponyo (2008) BluRay 1080p YTS YIFY")
        )
    }

}
