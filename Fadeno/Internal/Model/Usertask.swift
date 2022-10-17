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
    
    init(_ order: Int, _ title: String = "", _ outline: String = "", _ content: String = "",
         _ complete: Bool = false, _ type: Tasktype = .todo) {
        self.id = UUID()
        self.order = order
        self.title = title
        self.outline = outline
        self.content = content
        self.type = type
        self.complete = false
    }
    
    init(_ mo: UsertaskMo) {
        self.id = mo.id ?? UUID()
        self.order = Int(mo.order)
        self.title = mo.title ?? ""
        self.outline = mo.outline ?? ""
        self.content = mo.content ?? ""
        self.type = Tasktype(rawValue: Int(mo.type)) ?? .todo
        self.complete = mo.complete
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
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init(0)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.order = try container.decode(Int.self, forKey: .order)
        self.title = try container.decode(String.self, forKey: .title)
        self.outline = try container.decode(String.self, forKey: .outline)
        self.content = try container.decode(String.self, forKey: .content)
        self.type = try container.decode(Tasktype.self, forKey: .type)
        self.complete = try container.decode(Bool.self, forKey: .complete)
    }
}

extension Usertask: Identifiable {}

extension Usertask: Equatable {
    static func == (lhs: Usertask, rhs: Usertask) -> Bool {
        lhs.id == rhs.id
    }
}

extension Usertask {
    static var empty = Usertask(0)
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
    }
}

// MARK: Tasktype
extension Usertask {
    enum Tasktype: Int {
    case todo, normal, urgent, archive, custom
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
            return .yellow
        case .archive:
            return .gray
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
        case .archive:
            return String(localized: "archive")
        }
    }
}


