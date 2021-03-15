@testable import AlfredKatCore
import SwiftSoup
import XCTest

@testable import AlfredKatCore

class TorrentMenuItemBuilderTests: XCTestCase {
    static var row: Element?

    override class func setUp() {
        super.setUp()

        // TODO: absolutely refactor this disgusting shit below
        let query = "ponyo"

        XCTestCase().spoofUserQuery(with: query)
        
        row = try? Entrance.searchOnline(for: query)?.first
    }
}

extension TorrentMenuItemBuilderTests {
//    func test_that_it_can_build_the_item_title() throws {
//        XCTAssertTrue(
//            try TorrentMenuItemBuilder.title(for: row!).contains("ago by YTSAGx, 1.7 GB")
//        )
//    }

    func test_that_it_can_build_the_item_subtitle() throws {
        if let row = TorrentMenuItemBuilderTests.row {
            XCTAssertTrue(
                TorrentMenuItemBuilder.subtitle(for: row).contains("Ponyo (2008) BluRay 1080p YTS YIFY")
            )
        } else {
            XCTFail("issue with grabbing torrents from online")
        }
    }
}
