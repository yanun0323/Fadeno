import SwiftUI

struct UsertaskInteractor {
    var appstate: AppState
    
    init(appstate: AppState) {
        self.appstate = appstate
    }
}

extension UsertaskInteractor {
    func UpdateUsertask(_ task: Usertask) {
        appstate.userdata.tasks.first(where: { $0.id == task.id })?.Update(task)
    }
    
    func CreateUsertask(_ task: Usertask) {
        var lastOrder = 0
        appstate.userdata.tasks.forEach { t in
            if t.type == task.type && t.order > lastOrder {
                lastOrder = t.order
            }
        }
        task.order = lastOrder+1
        appstate.userdata.tasks.append(task)
    }
    
//    func MoveUsertask(_ task: Usertask, _ targetType: Usertask.Tasktype, _ targetIndex: Int) {
//
//    }
    
    func InsertUsertask(_ task: Usertask) {
        print("insert usertask \(task.title) \(task.order)")
        appstate.userdata.tasks.forEach { t in
            if t.type == task.type && t.order >= task.order {
                t.order += 1
            }
        }
        appstate.userdata.tasks.append(task)
    }
    
    func RemoveUsertask(_ task: Usertask) {
        print("remove usertask \(task.title) \(task.order)")
        print("tasks count before \(appstate.userdata.tasks.count)")
        guard let i = appstate.userdata.tasks.firstIndex(where: { $0.id == task.id }) else { return }
        let removed = appstate.userdata.tasks.remove(at: i)
        
        print("tasks count after \(appstate.userdata.tasks.count)")
        appstate.userdata.tasks.forEach { t in
            if t.type == removed.type && t.order > removed.order {
                t.order -= 1
            }
        }
    }
}
