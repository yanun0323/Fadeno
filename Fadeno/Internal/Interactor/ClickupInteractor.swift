//
//  ClickupInteractor.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/31.
//

import SwiftUI

struct ClickupInteractor {
    private var appstate: AppState
    private var repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension ClickupInteractor {
    func SetToken(_ token: String) {
        repo.SetClickupAPIToken(token)
    }
    
    func GetToken() -> String {
        repo.GetClickupAPIToken()
    }
    
    func VerifyToken(_ token: String) {
        DispatchQueue.main.async {
            var valid = false
            if !token.isEmpty {
                valid = repo.VerifyClickupAPIToken(token)
            }
            appstate.clickup.tokenVerify.send(valid)
            if valid {
                repo.SetClickupAPIToken(token)
            }
        }
    }
    
    func GetTeamID() -> String {
        let team = repo.GetClickupTeam()
        return team?.id ?? ""
    }
    
    func GetUserID() -> String {
        let user = repo.GetClickupUser()
        return user?.id.description ?? ""
    }
    
    func ListTaks() {
        DispatchQueue.global().async {
            appstate.clickup.tasks.send(repo.ListClickupTasks())
        }
    }
    
    func GetTask(_ taskID: String) {
        DispatchQueue.global().async {
            appstate.clickup.currentTask.send(repo.GetTask(taskID))
        }
    }
}
