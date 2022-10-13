import SwiftUI
import CoreData

extension Dao {
    class UserTaskDao {
        var container: NSPersistentContainer
        var taskDict: Dictionary<UUID,UserTaskMo>
        
        init(_ container: NSPersistentContainer) {
            self.container = container
            self.taskDict = [:]
            
            let request = NSFetchRequest<UserTaskMo>(entityName:"UserTaskMo")
            do {
                let arr = try self.container.viewContext.fetch(request)
                
                for task in arr {
                    self.taskDict[task.id!] = task
                }
                
            } catch {
                print("ERROR fetching. \(error)")
            }
        }
    }
}

//extension Dao.UserTaskDao: UserTaskRepository {
//    func getUserTasks(_ type: UserTask.TaskType) -> [UserTask] {
//        var result: [UserTask] = []
//        for v in taskDict {
//            if Int(v.value.type) == type.rawValue {
//                result.append(UserTask(v.value))
//            }
//        }
//        return result
//    }
//    
//    func updateUserTask(_ task: UserTask, _ id: UUID) -> Error? {
//        if taskDict[id] == nil { return }
//        return nil
//    }
//    
//    func deleteUserTask(_: UserTask, _: UUID) -> Error? {
//        return nil
//    }
//    
//    func createUserTasks(_: UserTask) -> Error? {
//        return nil
//    }
//    
//    
//}
