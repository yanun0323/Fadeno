//
//  UserSettingDao.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/29.
//

import Foundation
import AppKit
import UIComponent

protocol UserSettingDao {}

extension UserSettingDao where Self: UserSettingRepository {
    /**
     0 = system
     1 = light
     2 = dark
     */
    func SetAppereance(_ i:Int) {
        UserDefaults.appearance = i
    }
    
    func GetAppereance() -> NSAppearance? {
        guard let i = UserDefaults.appearance else { return nil }
        switch i {
        case 1:
            return .init(named: .aqua)
        case 2:
            return .init(named: .darkAqua)
        default:
            return nil
        }
    }
}

extension UserDefaults {
    @UserDefault(key: "Appearance")
    static var appearance: Int?
}
