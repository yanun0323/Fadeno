import Foundation
import SwiftUI

final class SwiftUIListReorder: NSObject, NSItemProviderReading, NSItemProviderWriting, Codable {
    static var readableTypeIdentifiersForItemProvider: [String] = ["com.apple.SwiftUI.listReorder"]
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> SwiftUIListReorder {
        let decoder = JSONDecoder()
        let reorderData = try decoder.decode(SwiftUIListReorder.self, from: data)
        return reorderData
    }
    
    static var writableTypeIdentifiersForItemProvider: [String] = ["com.apple.SwiftUI.listReorder"]
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let encoder = JSONEncoder()
        do {
            let json = try encoder.encode(self)
            completionHandler(json, nil)
        } catch {
            print(error.localizedDescription)
            completionHandler(nil, error)
        }
        return nil
    }
    
    var usertask: Usertask
    init(_ values: Usertask) {
        self.usertask = values
    }
    
}
