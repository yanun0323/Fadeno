import Foundation
import CoreData
import Combine

struct UserTaskRepository {
    var container: NSManagedObjectContext
    var publiser = PassthroughSubject<[UserTask], Never>()
}

extension UserTaskRepository {
    func userTasks(_ type: UserTask.TaskType) -> AnyPublisher<[UserTask], Never> {
        return publiser.eraseToAnyPublisher()
    }
}
