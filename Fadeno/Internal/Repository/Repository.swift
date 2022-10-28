//
//  Repository.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/26.
//

import Foundation

protocol Repository: UsertaskRepository, UserSettingRepository {}

protocol UsertaskRepository {
    func CreateTask(_ usertask: Usertask)
    func GetCurrentTask() -> Usertask?
    func SetCurrentTask(_ usertask: Usertask?)
    func GetUsertask(_ id: UUID) -> Usertask?
    func UpdateUsertask(_ usertask: Usertask)
    func DeleteUsertask(_ usertask: Usertask)
    func ListTasks() -> [Usertask]
    func UpdateTasks(_ tasks: [Usertask])
}

protocol UserSettingRepository {}
