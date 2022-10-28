//
//  Dao.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/26.
//

import Foundation

final class DaoMock {
    var tasks: [Usertask] = [
        .preview.archive,
        .preview.normal,
        .preview.todo,
        .preview.urgent,
        .preview.urgent1
    ]
    var currentTask: Usertask? = nil
     
    init() {}
}

extension DaoMock: Repository {}

extension DaoMock: UsertaskRepository {
    func CreateTask(_ usertask: Usertask) {
        var lastOrder = 0
        tasks.forEach { t in
            if t.type == usertask.type && t.order > lastOrder {
                lastOrder = t.order
            }
        }
        usertask.order = lastOrder+1
        tasks.append(usertask)
    }
    
    func GetCurrentTask() -> Usertask? {
        return currentTask
    }
    
    func SetCurrentTask(_ usertask: Usertask?) {
        currentTask = usertask
    }
    
    func GetUsertask(_ id: UUID) -> Usertask? {
        return tasks.first(where: { $0.id == id })
    }
    
    func UpdateUsertask(_ usertask: Usertask) {
        guard let task = tasks.first(where: { $0.id == usertask.id }) else { return }
        task.Update(usertask)
    }
    
    func DeleteUsertask(_ usertask: Usertask) {
        guard let i = tasks.firstIndex(where: { $0.id == usertask.id }) else { return }
        let removed = tasks.remove(at: i)
        tasks.forEach { t in
            if t.type == removed.type && t.order > removed.order {
                t.order -= 1
            }
        }
    }
    
    func ListTasks() -> [Usertask] {
        return tasks
    }
    
    func UpdateTasks(_ tasks: [Usertask]) {
        self.tasks = tasks
        if let task = self.tasks.first(where: { $0.id == currentTask?.id }) {
            currentTask?.Update(task)
        } else {
            currentTask = nil
        }
    }
}
