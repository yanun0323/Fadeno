import Foundation
import CoreData
import Combine

struct UsertaskRepository {
    var container: NSManagedObjectContext
    var publiser = PassthroughSubject<[Usertask], Never>()
}

extension UsertaskRepository {
    func userTasks(_ type: Usertask.Tasktype) -> AnyPublisher<[Usertask], Never> {
        return publiser.eraseToAnyPublisher()
    }
}
