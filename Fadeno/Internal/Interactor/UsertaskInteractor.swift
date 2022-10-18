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
    
    /**
     Create a new usertask after the type of last order
     */
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
    
    /**
     Move an usertask order in the same type
     */
    func MoveUsertask(_ task: Usertask, _ targetIndex: Int) {
        if task.order == targetIndex {
            return
        }
        
        
    }
    
    
    /**
     Insert an usertask order from the other type
     */
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
        guard let i = appstate.userdata.tasks.firstIndex(where: { $0.id == task.id }) else { return }
        let removed = appstate.userdata.tasks.remove(at: i)
        
        appstate.userdata.tasks.forEach { t in
            if t.type == removed.type && t.order > removed.order {
                t.order -= 1
            }
        }
    }
}
