import SwiftUI

struct UsertaskInteractor {
    var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
}

extension UsertaskInteractor {
    func UpdateUsertask(_ task: Usertask) {
        appState.userdata.tasks.first(where: { $0.id == task.id })?.Update(task)
    }
}
