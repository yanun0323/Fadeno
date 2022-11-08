//
//  Clickup.swift
//  Fadeno
//
//  Created by YanunYang on 2022/11/2.
//

import Foundation

struct Clickup {}

extension Clickup {
    // MARK: - Teams
    struct Teams: Codable {
        var teams: [Team]
    }
    
    // MARK: - Team
    struct Team: Codable {
        var id: String
        var name: String
        var color: String?
        var avatar: String?
        var members: [Member]
    }
    
    // MARK: - Member
    struct Member: Codable {
        var user: User?
        var invited_by: User?
    }
    
    // MARK: - UserWrapped
    struct UserWrapped: Codable {
        var user: User
    }
    
    // MARK: - User
    struct User: Codable {
        var id: Int
        var username: String?
        var email: String?
        var color: String?
        var profilePicture: String?
        var initials: String?
        var role: Int?
        var weekStartDay: Int?
        var globalFontSupport: Bool?
        var custom_role: Int?
        var last_active: String?
        var date_joined: String?
        var date_invited: String?
        var timezone: String?
    }
}


extension Clickup {
    // MARK: - Tasks
    struct Tasks: Codable {
        let tasks: [Task]
    }

    // MARK: - Task
    struct Task: Codable {
        let id: String
        let customID: String?
        var name: String?
        var textContent, taskDescription: String?
        let status: Status
        let orderindex, dateCreated, dateUpdated: String?
        let dateClosed: JSONNull?
        let archived: Bool?
        let creator: Creator?
        let assignees: [Creator]
        let watchers: [User]
        let checklists: [Checklist]
        let tags: [Tag]
        let parent: JSONNull?
        let priority: PriorityClass?
        let dueDate, startDate: String?
        let points: Int?
        let timeEstimate: JSONNull?
        let customFields: [CustomField]
        let dependencies: [JSONAny]
        let linkedTasks: [LinkedTask]
        let teamID: String?
        let url: String?
        let permissionLevel: String?
        let list, project, folder: Folder?
        let space: Space?

        enum CodingKeys: String, CodingKey {
            case id
            case customID = "custom_id"
            case name
            case textContent = "text_content"
            case taskDescription = "description"
            case status, orderindex
            case dateCreated = "date_created"
            case dateUpdated = "date_updated"
            case dateClosed = "date_closed"
            case archived, creator, assignees, watchers, checklists, tags, parent, priority
            case dueDate = "due_date"
            case startDate = "start_date"
            case points
            case timeEstimate = "time_estimate"
            case customFields = "custom_fields"
            case dependencies
            case linkedTasks = "linked_tasks"
            case teamID = "team_id"
            case url
            case permissionLevel = "permission_level"
            case list, project, folder, space
        }
    }

    // MARK: - Creator
    struct Creator: Codable {
        let id: Int?
        let username, color: String?
        let initials: String?
        let email: String?
        let profilePicture: String?
    }

    // MARK: - Checklist
    struct Checklist: Codable {
        let id, taskID, name, dateCreated: String?
        let orderindex, creator, resolved, unresolved: Int?
        let items: [Item]

        enum CodingKeys: String, CodingKey {
            case id
            case taskID = "task_id"
            case name
            case dateCreated = "date_created"
            case orderindex, creator, resolved, unresolved, items
        }
    }

    // MARK: - Item
    struct Item: Codable {
        let id, name: String?
        let orderindex: Double?
        let assignee: Creator?
        let groupAssignee: GroupAssignee?
        let resolved: Bool?
        let parent: JSONNull?
        let dateCreated: String?
        let children: [JSONAny]

        enum CodingKeys: String, CodingKey {
            case id, name, orderindex, assignee
            case groupAssignee = "group_assignee"
            case resolved, parent
            case dateCreated = "date_created"
            case children
        }
    }

    // MARK: - GroupAssignee
    struct GroupAssignee: Codable {
        let id, teamID: String?
        let userid: Int?
        let name, handle, dateCreated, initials: String?
        let members: [Creator]
        let avatar: Avatar?

        enum CodingKeys: String, CodingKey {
            case id
            case teamID = "team_id"
            case userid, name, handle
            case dateCreated = "date_created"
            case initials, members, avatar
        }
    }

    // MARK: - Avatar
    struct Avatar: Codable {
        let attachmentID, color, source, icon: JSONNull?

        enum CodingKeys: String, CodingKey {
            case attachmentID = "attachment_id"
            case color, source, icon
        }
    }

    // MARK: - CustomField
    struct CustomField: Codable {
        let id, name: String?
        let type: CustomFieldType?
        let typeConfig: TypeConfig?
        let dateCreated: String?
        let hideFromGuests, customFieldRequired: Bool?
        let value: CustomFieldValue?

        enum CodingKeys: String, CodingKey {
            case id, name, type
            case typeConfig = "type_config"
            case dateCreated = "date_created"
            case hideFromGuests = "hide_from_guests"
            case customFieldRequired = "required"
            case value
        }
    }

    enum CustomFieldType: String, Codable {
        case attachment = "attachment"
        case automaticProgress = "automatic_progress"
        case checkbox = "checkbox"
        case date = "date"
        case dropDown = "drop_down"
        case email = "email"
        case labels = "labels"
        case shortText = "short_text"
        case text = "text"
        case users = "users"
    }

    // MARK: - TypeConfig
    struct TypeConfig: Codable {
        let typeConfigDefault: Int?
        let placeholder: JSONNull?
        let options: [Option]?
        let tracking: Tracking?
        let completeOn: Int?
        let subtaskRollup, newDropDown, singleUser: Bool?
        let includeGroups: JSONNull?
        let includeGuests, includeTeamMembers: Bool?

        enum CodingKeys: String, CodingKey {
            case typeConfigDefault = "default"
            case placeholder, options, tracking
            case completeOn = "complete_on"
            case subtaskRollup = "subtask_rollup"
            case newDropDown = "new_drop_down"
            case singleUser = "single_user"
            case includeGroups = "include_groups"
            case includeGuests = "include_guests"
            case includeTeamMembers = "include_team_members"
        }
    }

    // MARK: - Option
    struct Option: Codable {
        let id: String?
        let name: String?
        let color: String?
        let orderindex: Int?
        let label: String?
    }

    // MARK: - Tracking
    struct Tracking: Codable {
        let subtasks: Bool?
        let checklists, assignedComments: Bool?

        enum CodingKeys: String, CodingKey {
            case subtasks, checklists
            case assignedComments = "assigned_comments"
        }
    }

    enum CustomFieldValue: Codable {
        case integer(Int)
        case string(String)
        case unionArray([ValueElement])
        case valueClass(ValueClass)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Int.self) {
                self = .integer(x)
                return
            }
            if let x = try? container.decode([ValueElement].self) {
                self = .unionArray(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            if let x = try? container.decode(ValueClass.self) {
                self = .valueClass(x)
                return
            }
            throw DecodingError.typeMismatch(CustomFieldValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CustomFieldValue"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .integer(let x):
                try container.encode(x)
            case .string(let x):
                try container.encode(x)
            case .unionArray(let x):
                try container.encode(x)
            case .valueClass(let x):
                try container.encode(x)
            }
        }
    }

    enum ValueElement: Codable {
        case creator(Creator)
        case string(String)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            if let x = try? container.decode(Creator.self) {
                self = .creator(x)
                return
            }
            throw DecodingError.typeMismatch(ValueElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ValueElement"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .creator(let x):
                try container.encode(x)
            case .string(let x):
                try container.encode(x)
            }
        }
    }

    // MARK: - ValueClass
    struct ValueClass: Codable {
        let percentComplete: Int?

        enum CodingKeys: String, CodingKey {
            case percentComplete = "percent_complete"
        }
    }

    // MARK: - Folder
    struct Folder: Codable {
        let id, name: String?
        let hidden: Bool?
        let access: Bool?
    }

    // MARK: - LinkedTask
    struct LinkedTask: Codable {
        let taskID, linkID, dateCreated, userid: String?
        let workspaceID: String?

        enum CodingKeys: String, CodingKey {
            case taskID = "task_id"
            case linkID = "link_id"
            case dateCreated = "date_created"
            case userid
            case workspaceID = "workspace_id"
        }
    }

    // MARK: - PriorityClass
    struct PriorityClass: Codable {
        let id: String?
        let priority: String?
        let color: String?
        let orderindex: String?
    }

    // MARK: - Space
    struct Space: Codable {
        let id: String
    }

    // MARK: - Status
    struct Status: Codable {
        let status, color: String
        let type: StatusType
        let orderindex: Int
    }

    enum StatusType: String, Codable {
        case custom = "custom"
        case done = "done"
        case typeOpen = "open"
        case unstarted = "unstarted"
    }

    // MARK: - Tag
    struct Tag: Codable {
        let name, tagFg, tagBg: String
        let creator: Int

        enum CodingKeys: String, CodingKey {
            case name
            case tagFg = "tag_fg"
            case tagBg = "tag_bg"
            case creator
        }
    }

    // MARK: - Encode/decode helpers

    class JSONNull: Codable, Hashable {

        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
        }

//        public var hashValue: Int {
//            return 0
//        }

        public init() {}

        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(0)
        }
    }

    class JSONCodingKey: CodingKey {
        let key: String

        required init?(intValue: Int) {
            return nil
        }

        required init?(stringValue: String) {
            key = stringValue
        }

        var intValue: Int? {
            return nil
        }

        var stringValue: String {
            return key
        }
    }

    class JSONAny: Codable {

        let value: Any

        static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
        }

        static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
        }

        static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                return value
            }
            if let value = try? container.decode(Int64.self) {
                return value
            }
            if let value = try? container.decode(Double.self) {
                return value
            }
            if let value = try? container.decode(String.self) {
                return value
            }
            if container.decodeNil() {
                return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
        }

        static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                return value
            }
            if let value = try? container.decode(Int64.self) {
                return value
            }
            if let value = try? container.decode(Double.self) {
                return value
            }
            if let value = try? container.decode(String.self) {
                return value
            }
            if let value = try? container.decodeNil() {
                if value {
                    return JSONNull()
                }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
        }

        static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                if value {
                    return JSONNull()
                }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
        }

        static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                let value = try decode(from: &container)
                arr.append(value)
            }
            return arr
        }

        static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                let value = try decode(from: &container, forKey: key)
                dict[key.stringValue] = value
            }
            return dict
        }

        static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                if let value = value as? Bool {
                    try container.encode(value)
                } else if let value = value as? Int64 {
                    try container.encode(value)
                } else if let value = value as? Double {
                    try container.encode(value)
                } else if let value = value as? String {
                    try container.encode(value)
                } else if value is JSONNull {
                    try container.encodeNil()
                } else if let value = value as? [Any] {
                    var container = container.nestedUnkeyedContainer()
                    try encode(to: &container, array: value)
                } else if let value = value as? [String: Any] {
                    var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                    try encode(to: &container, dictionary: value)
                } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
                }
            }
        }

        static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                let key = JSONCodingKey(stringValue: key)!
                if let value = value as? Bool {
                    try container.encode(value, forKey: key)
                } else if let value = value as? Int64 {
                    try container.encode(value, forKey: key)
                } else if let value = value as? Double {
                    try container.encode(value, forKey: key)
                } else if let value = value as? String {
                    try container.encode(value, forKey: key)
                } else if value is JSONNull {
                    try container.encodeNil(forKey: key)
                } else if let value = value as? [Any] {
                    var container = container.nestedUnkeyedContainer(forKey: key)
                    try encode(to: &container, array: value)
                } else if let value = value as? [String: Any] {
                    var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                    try encode(to: &container, dictionary: value)
                } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
                }
            }
        }

        static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }

        public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                let container = try decoder.singleValueContainer()
                self.value = try JSONAny.decode(from: container)
            }
        }

        public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                var container = encoder.unkeyedContainer()
                try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                var container = encoder.container(keyedBy: JSONCodingKey.self)
                try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                var container = encoder.singleValueContainer()
                try JSONAny.encode(to: &container, value: self.value)
            }
        }
    }

}

extension Clickup {
    static func NewEmptyTask(_ id: String) -> Clickup.Task {
        Clickup.Task(id: id, customID: nil, name: nil, textContent: nil, taskDescription: nil, status: Status(status: "Error", color: "#fff", type: .custom, orderindex: 0), orderindex: nil, dateCreated: nil, dateUpdated: nil, dateClosed: nil, archived: nil, creator: nil, assignees: [], watchers: [], checklists: [], tags: [], parent: nil, priority: nil, dueDate: nil, startDate: nil, points: nil, timeEstimate: nil, customFields: [], dependencies: [], linkedTasks: [], teamID: nil, url: nil, permissionLevel: nil, list: nil, project: nil, folder: nil, space: nil)
    }
    
    static func NewErrorTask(_ id: String, _ err: Error) -> Clickup.Task {
        var empty = NewEmptyTask("error - \(id)")
        empty.name = err.localizedDescription
        empty.textContent = err.localizedDescription
        return empty
    }
}
