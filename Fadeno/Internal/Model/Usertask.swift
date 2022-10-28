import Foundation
import SwiftUI

final class Usertask {
    var id: UUID = UUID()
    var order: Int
    var title: String
    var outline: String
    var content: String
    var type: Tasktype
    var complete: Bool
    var updateTime: Date
    
    init(_ order: Int = 0, _ title: String = "", _ outline: String = "", _ content: String = "",
         _ complete: Bool = false, _ type: Tasktype = .todo) {
        self.id = UUID()
        self.order = order
        self.title = title
        self.outline = outline
        self.content = content
        self.type = type
        self.complete = false
        self.updateTime = .now
    }
    
    init(_ mo: UsertaskMO) {
        self.id = mo.id!
        self.order = Int(mo.order)
        self.title = mo.title!
        self.outline = mo.outline!
        self.content = mo.content!
        self.type = Tasktype(rawValue: Int(mo.type)) ?? .todo
        self.complete = mo.complete
        self.updateTime = mo.updateTime ?? .now
    }
}

// MARK: Codable
extension Usertask: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.order, forKey: .order)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.outline, forKey: .outline)
        try container.encode(self.content, forKey: .content)
        try container.encode(self.type.rawValue, forKey: .type)
        try container.encode(self.complete, forKey: .complete)
        try container.encode(self.updateTime, forKey: .updateTime)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case mo
        case order
        case title
        case outline
        case content
        case type
        case complete
        case updateTime
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.order = try container.decode(Int.self, forKey: .order)
        self.title = try container.decode(String.self, forKey: .title)
        self.outline = try container.decode(String.self, forKey: .outline)
        self.content = try container.decode(String.self, forKey: .content)
        self.type = try container.decode(Tasktype.self, forKey: .type)
        self.complete = try container.decode(Bool.self, forKey: .complete)
        self.updateTime = try container.decode(Date.self, forKey: .updateTime)
    }
}

extension Usertask: Identifiable {}

extension Usertask: Equatable {
    static func == (lhs: Usertask, rhs: Usertask) -> Bool {
        lhs.hashID == rhs.hashID
    }
}

// MARK: Property
extension Usertask {
    var hashID: String {
        "\(id)-\(order)-\(title.count)-\(title.count)-\(outline.count)-\(content.count)-\(type.rawValue)-\(complete.description)"
    }
    
    var isArchived: Bool {
        type == .archived
    }
    
    var isComplete: Bool {
        type == .complete
    }
}

// MARK: Function
extension Usertask {
    func Update(_ task: Usertask) {
        self.order = task.order
        self.title = task.title
        self.outline = task.outline
        self.content = task.content
        self.type = task.type
        self.complete = task.complete
        self.updateTime = .now
    }
    
    func RefreshUpdateDate() {
        self.updateTime = .now
    }
}

// MARK: Tasktype
extension Usertask {
    enum Tasktype: Int {
    case todo, normal, urgent, archived, custom, complete
    }
}

extension Usertask.Tasktype: Codable {}
extension Usertask.Tasktype: CaseIterable {}
extension Usertask.Tasktype: Identifiable {
    var id: Int {
        self.rawValue
    }
}

extension Usertask.Tasktype {
    var color: Color {
        switch self {
        case .todo:
            return .gray
        case .normal:
            return .blue
        case .urgent:
            return .red
        case .custom:
            return .cyan
        case .archived:
            return .yellow
        case .complete:
            return .purple
        }
    }
    
    var title: String {
        switch self {
        case .todo:
            return String(localized: "todo")
        case .normal:
            return String(localized: "normal")
        case .urgent:
            return String(localized: "urgent")
        case .custom:
            return String(localized: "custom")
        case .archived:
            return String(localized: "archived")
        case .complete:
            return String(localized: "completed")
        }
    }
}


