import Foundation


struct ReleaseInfo: Codable {
    
    let version: String
    let file: String
    let page: String
    
}


struct Updater {
    
    static func updateAvailable() -> ReleaseInfo? {
        guard let alfredWorkflowCache = ProcessInfo.processInfo.environment["alfred_workflow_cache"] else { return nil }
        
        let releaseFile = URL(fileURLWithPath: "\(alfredWorkflowCache)/update_available.plist")
        guard let releaseData = try? Data(contentsOf: releaseFile) else { return nil }
        
        let decoder = PropertyListDecoder()
        guard let releaseInfo = try? decoder.decode(ReleaseInfo.self, from: releaseData) else { return nil }
        
        return releaseInfo
    }
    
}
