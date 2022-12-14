//
//  UsertaskDao.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/29.
//

import Foundation
import CoreData

extension Dao {
    class UsertaskDaoDelegate {
        var currentTask: Usertask? = nil
    }
}

protocol UsertaskDao {
    var delegateUD: Dao.UsertaskDaoDelegate { get set }
    var ctx: NSManagedObjectContext { get set }
    var request: NSFetchRequest<UsertaskMO> { get set }
}

extension UsertaskDao where Self: UsertaskRepository {
    func CreateTask(_ usertask: Usertask) {
        do {
            var lastOrder: Int32 = -1
            let type = Int32(usertask.type.rawValue)
            try self.ctx.fetch(self.request).forEach({ mo in
                if mo.type == type && mo.order > lastOrder {
                    lastOrder += 1
                }
            })
            usertask.order = Int(lastOrder)+1
            UsertaskMO(context: self.ctx).Update(from: usertask)
            try self.ctx.save()
        } catch {
            print("create usertask failed, \(error)")
        }
    }
    
    func GetCurrentTask() -> Usertask? {
        return delegateUD.currentTask
    }
    
    func SetCurrentTask(_ usertask: Usertask?) {
        guard let task = usertask else {
            delegateUD.currentTask = nil
            return
        }
        if delegateUD.currentTask?.id == usertask?.id {
            print("same current task")
            return
        }
        do {
            self.delegateUD.currentTask = try self.ctx.fetch(self.request).first(where: { $0.id! == task.id })?.New() ?? nil
        } catch {
            print("set current task failed, \(error)")
        }
    }
    
    func GetUsertask(_ id: UUID) -> Usertask? {
        do {
            return try self.ctx.fetch(self.request).first(where: { $0.id! == id })?.New() ?? nil
        } catch {
            print("get usertask failed, \(error)")
            return nil
        }
    }
    
    func UpdateUsertask(_ usertask: Usertask) {
        do {
            guard let mo = try self.ctx.fetch(self.request).first(where: { $0.id! == usertask.id }) else {
                print("can't find usertask from database, usertask id: \(usertask.id)")
                return
            }
            mo.Update(from: usertask)
            try self.ctx.save()
        } catch {
            print("update usertask failed, \(error)")
        }
        
        if let t = self.delegateUD.currentTask {
            self.SetCurrentTask(t)
        }
    }
    
    func DeleteUsertask(_ usertask: Usertask) {
        do {
            guard let mo = try self.ctx.fetch(self.request).first(where: { $0.id! == usertask.id }) else {
                print("can't find usertask from database, usertask id: \(usertask.id)")
                return
            }
            self.ctx.delete(mo)
            try self.ctx.save()
        } catch {
            print("delete usertask failed, \(error)")
        }
        
        if let t = self.delegateUD.currentTask  {
            self.SetCurrentTask(t)
        }
    }
    
    func ListTasks() -> [Usertask] {
        do {
            return try self.ctx.fetch(self.request).map({ $0.New() })
        } catch {
            print("list tasks failed, \(error)")
            return []
        }
    }
    
    func UpdateTasks(_ tasks: [Usertask]) {
        for task in tasks {
            self.UpdateUsertask(task)
        }
        
        if let t = self.delegateUD.currentTask  {
            self.SetCurrentTask(t)
        }
    }
}
