import Foundation
import Combine

protocol NSUserTaskInteractor {
    func userTasks(_:UserTask.TaskType) -> AnyPublisher<[UserTask], Never>
}

struct UserTaskInteractor: NSUserTaskInteractor {
    func userTasks(_: UserTask.TaskType) -> AnyPublisher<[UserTask], Never> {
        
    }
}
