//
//  Repository.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/26.
//

import Foundation
import AppKit

protocol Repository: UsertaskRepository, UserSettingRepository, ClickupRepository {}

protocol UsertaskRepository {
    func CreateTask(_:Usertask)
    func GetCurrentTask() -> Usertask?
    func SetCurrentTask(_:Usertask?)
    func GetUsertask(_:UUID) -> Usertask?
    func UpdateUsertask(_:Usertask)
    func DeleteUsertask(_:Usertask)
    func ListTasks() -> [Usertask]
    func UpdateTasks(_:[Usertask])
}

protocol UserSettingRepository {
    func SetAppereance(_:Int)
    func GetAppereance() -> NSAppearance?
    func SetTaskbarVertical(_:Bool)
    func GetTaskbarVertical() -> Bool?
}

protocol ClickupRepository {
    func SetClickupAPIToken(_:String)
    func GetClickupAPIToken() -> String
    func VerifyClickupAPIToken(_:String) -> Bool
    func GetClickupTeam() -> Clickup.Team?
    func GetClickupUser() -> Clickup.User?
    func ListClickupTasks() -> [Clickup.Task]
    func GetTask(_:String) -> Clickup.Task?
}
