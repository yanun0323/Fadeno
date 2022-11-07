//
//  ClickupDao.swift
//  Fadeno
//
//  Created by YanunYang on 2022/11/1.
//

import Foundation
import UIComponent

protocol ClickupDao {}

extension ClickupDao where Self: ClickupRepository {
    func SetClickupAPIToken(_ token: String) {
        UserDefaults.clickUpAPIToken = token
    }
    
    func GetClickupAPIToken() -> String {
        UserDefaults.clickUpAPIToken ?? ""
    }
    
    func VerifyClickupAPIToken(_ token: String) -> Bool {
        let url = "https://api.clickup.com/api/v2/user"
        guard let code = Http.RequestStatusCode(.GET, toUrl: url, action: { request in
            var req = request
            req.setValue(token, forHTTPHeaderField: "Authorization")
            return req
        }) else {
            print("verify token request failed")
            return false
        }
        return 200 <= code && code < 300
    }
    
    func GetClickupTeam() -> Clickup.Team? {
        let url = "https://api.clickup.com/api/v2/team"
        guard let team = Http.SendRequest(toUrl: url, type: Clickup.Teams.self, action: { requset in
            var req = requset
            req.setValue(GetClickupAPIToken(), forHTTPHeaderField: "Authorization")
            return req
        }) else {
            print("get user team ID request failed")
            return nil
        }
        
        return team.teams.first
    }
    
    func GetClickupUser() -> Clickup.User? {
        let url = "https://api.clickup.com/api/v2/user"
        guard let user = Http.SendRequest(toUrl: url, type: Clickup.UserWrapped.self, action: { requset in
            var req = requset
            req.setValue(GetClickupAPIToken(), forHTTPHeaderField: "Authorization")
            return req
        }) else {
            print("get user team ID request failed")
            return nil
        }
        
        return user.user
    }
    
    func ListClickupTasks() -> [Clickup.Task] {
        guard let teamID = GetClickupTeam()?.id else { return [] }
        guard let userID = GetClickupUser()?.id else { return [] }
        let url = "https://api.clickup.com/api/v2/team/\(teamID)/task?assignees=\(userID)&assignees=\(userID)"
        print(url)
        guard let tasks = Http.SendRequest(toUrl: url, type: Clickup.Tasks.self, action: { requset in
            var req = requset
            req.setValue(GetClickupAPIToken(), forHTTPHeaderField: "Authorization")
            return req
        }) else {
            print("get task request failed")
            return []
        }
        
        return tasks.tasks
    }
}

extension UserDefaults {
    @UserDefault(key: "ClickupAPIToken")
    static var clickUpAPIToken: String?
}
