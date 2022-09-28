//
//  UserTask.swift
//  Fadeno
//
//  Created by YanunYang on 2022/9/21.
//

import Foundation
import SwiftUI

class UserTask: ObservableObject {
    var id: UUID
    @Published var title: String
    @Published var outline: String
    @Published var content: String
    @Published var type: TaskType
    @Published var complete: Bool
    
    init(_ title: String = "", _ outline: String = "", _ content: String = "",
         _ complete: Bool = false, _ type: TaskType = .todo) {
        self.id = UUID()
        self.title = title
        self.outline = outline
        self.content = content
        self.type = type
        self.complete = false
    }
}

extension UserTask: Identifiable {}

enum TaskType {
case  todo, process, urgent, archive
}

extension TaskType {
    var color: Color {
        .red
    }
}
