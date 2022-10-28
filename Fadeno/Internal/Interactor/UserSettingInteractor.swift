//
//  UserSettingInteractor.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/28.
//

import Foundation

class UserSettingInteractor {
    private var appstate: AppState
    
    init(appstate: AppState) {
        self.appstate = appstate
    }
}

extension UserSettingInteractor {
    UserDefaults.app
}
