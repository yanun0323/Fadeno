import Foundation
import SwiftUI

struct UserTask {
    var id: UUID
    var order: Int
    var title: String
    var outline: String
    var content: String
    var type: TaskType
    var complete: Bool
    
    init(_ order: Int, _ title: String = "", _ outline: String = "", _ content: String = "",
         _ complete: Bool = false, _ type: TaskType = .todo) {
        self.id = UUID()
        self.order = order
        self.title = title
        self.outline = outline
        self.content = content
        self.type = type
        self.complete = false
    }
    
    init(_ mo: UserTaskMo) {
        self.id = mo.id ?? UUID()
        self.order = Int(mo.order)
        self.title = mo.title ?? ""
        self.outline = mo.outline ?? ""
        self.content = mo.content ?? ""
        self.type = TaskType(rawValue: Int(mo.type)) ?? .todo
        self.complete = mo.complete
    }
}

extension UserTask: Identifiable {}

// MARK: Codable
extension UserTask: Codable {
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
        case order
        case title
        case outline
        case content
        case type
        case complete
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.order = try container.decode(Int.self, forKey: .order)
        self.title = try container.decode(String.self, forKey: .title)
        self.outline = try container.decode(String.self, forKey: .outline)
        self.content = try container.decode(String.self, forKey: .content)
        self.type = try container.decode(TaskType.self, forKey: .type)
        self.complete = try container.decode(Bool.self, forKey: .complete)
    }
}

extension UserTask: Equatable {}

extension UserTask {
    static var empty = UserTask(0)
}

extension UserTask {}

// MARK: TaskType
extension UserTask {
    enum TaskType: Int {
    case todo, normal, urgent, archive, custom
    }
}

extension UserTask.TaskType: Codable {}

extension UserTask.TaskType {
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
