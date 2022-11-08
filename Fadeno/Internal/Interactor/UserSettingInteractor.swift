//
//  UserSettingInteractor.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/28.
//

import Foundation
import AppKit

class UserSettingInteractor {
    private var appstate: AppState
    private var repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension UserSettingInteractor {
    /**
     0 = system
     1 = light
     2 = dark
     */
    func SetAppearance(_ i: Int) {
        repo.SetAppereance(i)
        let appearance = repo.GetAppereance()
        NSApp.appearance = appearance
        appstate.usersetting.appearance.send(appearance)
    }
    
    func GetAppearance() -> NSAppearance? {
        repo.GetAppereance()
    }
    
    func SetTaskbarVertical(_ value: Bool) {
        repo.SetTaskbarVertical(value)
    }
    
    func GetTaskbarVertical() -> Bool {
        repo.GetTaskbarVertical() ?? false
    }
}
