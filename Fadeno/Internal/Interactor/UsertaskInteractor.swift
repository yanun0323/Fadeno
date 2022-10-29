import SwiftUI

struct UsertaskInteractor {
    private var appstate: AppState
    private var repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension UsertaskInteractor {
    func SearchHandler(_ text: String, _ tasks: [Usertask]) -> [Usertask] {
        if text.isEmpty { return tasks }
        return tasks.filter { t in
            t.title.contains(text) || t.outline.contains(text) || t.content.contains(text)
        }
    }
    
    func GetUsertask(_ id: UUID) -> Usertask? {
        repo.GetUsertask(id)
    }
    
    func GetCurrentUsertask() -> Usertask? {
        repo.GetCurrentTask()
    }
    
    func SetCurrentUsertask(_ task: Usertask?) {
        repo.SetCurrentTask(task)
        Publish()
    }
    
    func UpdateUsertask(_ task: Usertask) {
        task.RefreshUpdateDate()
        repo.UpdateUsertask(task)
        Publish()
    }
    
    func DeleteUsertask(_ task: Usertask) {
        repo.DeleteUsertask(task)
        Publish()
    }
    
    func MoveUserTask(_ task: Usertask, toOrder: Int = 0, toType: Usertask.Tasktype) {
        repo.ListTasks().forEach { t in
            var changed = false
            if t.type == task.type && t.order > task.order && t.id != task.id {
                t.order -= 1
                changed.toggle()
            }
            if t.type == toType && t.order >= toOrder && t.id != task.id {
                t.order += 1
                changed.toggle()
            }
            if changed {
                repo.UpdateUsertask(t)
            }
        }
        task.order = toOrder
        task.type = toType
        repo.UpdateUsertask(task)
        Publish()
    }
    
    /**
     Create a new usertask after the type of last order
     */
    func CreateUsertask(_ task: Usertask) {
        print("create \(task.hashID)")
        repo.CreateTask(task)
        print("create done")
        Publish()
        print("create fetch done")
    }
    
    /**
     Insert an usertask order from the other type
     */
    func InsertUsertask(_ task: Usertask) {
        repo.ListTasks().forEach { t in
            if t.type == task.type && t.order >= task.order {
                t.order += 1
                repo.UpdateUsertask(t)
            }
        }
        repo.CreateTask(task)
        repo.UpdateUsertask(task)
        Publish()
    }
    
    func RemoveUsertask(_ task: Usertask) {
        var tasks = repo.ListTasks()
        guard let i = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        let removed = tasks.remove(at: i)
        
        tasks.forEach { t in
            if t.type == removed.type && t.order > removed.order {
                t.order -= 1
            }
        }
        repo.UpdateTasks(tasks)
        Publish()
    }
}

extension UsertaskInteractor {
    func Publish() {
        DispatchQueue.main.async {
            appstate.userdata.tasks.send(repo.ListTasks())
            appstate.userdata.currentTask.send(repo.GetCurrentTask())
        }
    }
}
