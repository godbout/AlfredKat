import Foundation
import SwiftSoup
import AlfredWorkflowScriptFilter

public class Workflow {
    private var shared = Workflow()

    private init() {}
    
    public static func userInput() -> String {
        return CommandLine.arguments[1]
    }

    public static func next() -> String {
        "next"
    }

    public static func menu() -> String {
        "menu"
    }

    public static func `do`() throws -> Bool {
        let input = Workflow.userInput()
        let urlString =  "https://kickasstorrents.to/usearch/" + (input.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")

        guard let url = URL(string: urlString) else { exit(1) }
        let html = try String(contentsOf: url)
        let document = try SwiftSoup.parse(html)
        let torrents = try document.select(".frontPageWidget tr").first()?.siblingElements()

        if let torrents = torrents {
            for torrent in torrents {
                ScriptFilter.add(
                    Item(title: try torrent.text())
                )
            }
        }
        
        return true
    }

    public static func notify(result: Bool = false) -> String {
        if result == false {
            return "oops. failed"
        }

        return "nice"
    }
}

