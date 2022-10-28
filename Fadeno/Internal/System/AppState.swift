import Foundation
import SwiftUI
import AppKit
import Combine
import UIComponent

class AppState {
    var userdata: UserData
    var markdown: MarkDownState
    var usersetting: UserSetting
    
    init() {
        self.userdata = UserData()
        self.markdown = MarkDownState()
        self.usersetting = UserSetting()
    }
}

extension AppState {
    class UserData {
        var page: Int
        var currentTask: PassthroughSubject<Usertask?, Never>
        var tasks: PassthroughSubject<[Usertask], Never>
        
        init(page: Int = 0, tasks: [Usertask] = []) {
            self.page = page
            self.tasks = PassthroughSubject()
            self.currentTask = PassthroughSubject()
        }
    }
}

extension AppState {
    struct MarkDownState {
        var focus: PassthroughSubject<Bool, Never> = .init()
    }
}

extension AppState {
    struct UserSetting {
        var appearance: PassthroughSubject<NSAppearance, Never>
        
        init() {
            self.appearance = PassthroughSubject()
        }
    }
}
