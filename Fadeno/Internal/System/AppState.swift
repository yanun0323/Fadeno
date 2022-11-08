import Foundation
import SwiftUI
import AppKit
import Combine
import UIComponent

class AppState {
    var userdata = UserData()
    var markdown = MarkDownState()
    var usersetting = UserSetting()
    var clickup = ClickupState()
}

extension AppState {
    class UserData {
        var page: Int = 0
        var tasks: PassthroughSubject<[Usertask], Never> = .init()
        var deleteTask: PassthroughSubject<Usertask, Never> = .init()
        var currentTask: PassthroughSubject<Usertask?, Never> = .init()
    }
}

extension AppState {
    struct MarkDownState {
        var focus: PassthroughSubject<Bool, Never> = .init()
    }
}

extension AppState {
    struct UserSetting {
        var appearance: PassthroughSubject<NSAppearance?, Never> = .init()
    }
}

extension AppState {
    struct ClickupState {
        var tokenVerify: PassthroughSubject<Bool, Never> = .init()
        var tasks: PassthroughSubject<[Clickup.Task], Never> = .init()
        var currentTask: PassthroughSubject<Clickup.Task?, Never> = .init()
    }
}
