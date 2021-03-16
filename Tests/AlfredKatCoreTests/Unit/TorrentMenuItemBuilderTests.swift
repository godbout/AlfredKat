@testable import AlfredKatCore
import SwiftSoup
import XCTest

@testable import AlfredKatCore

class TorrentMenuItemBuilderTests: XCTestCase {
    static var row: Element?

    override class func setUp() {
        super.setUp()

        let query = "ponyo"

        XCTestCase().spoofUserQuery(with: query)

        row = try? Entrance.searchOnline(for: query)?.first
    }
}

extension TorrentMenuItemBuilderTests {
    func test_that_it_can_build_the_item_title() throws {
        if let row = TorrentMenuItemBuilderTests.row {
            XCTAssertTrue(
                TorrentMenuItemBuilder.title(for: row).contains("ago by YTSAGx, 1.7 GB")
            )
        } else {
            XCTFail("can't seem to shit the correct title for the torrents")
        }
    }

    func test_that_it_can_build_the_item_subtitle() throws {
        if let row = TorrentMenuItemBuilderTests.row {
            XCTAssertEqual(TorrentMenuItemBuilder.subtitle(for: row), "Ponyo (2008) BluRay 1080p YTS YIFY")
        } else {
            XCTFail("can't generate the subtitle out of the torrents")
        }
    }

    func test_that_it_can_build_the_page_link() throws {
        if let row = TorrentMenuItemBuilderTests.row {
            XCTAssertEqual(TorrentMenuItemBuilder.pageLink(for: row), "/ponyo-2008-bluray-1080p-yts-yify-t3657848.html")
        } else {
            XCTFail("can't get the fucking torrent link out of the torrents")
        }
    }
}
