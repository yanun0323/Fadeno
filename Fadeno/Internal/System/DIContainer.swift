import Foundation

class DIContainer: ObservableObject {
    var appstate: AppState {
        willSet {
            objectWillChange.send()
        }
    }
    var interactor: Interactor
    
    init(appstate: AppState) {
        self.appstate = appstate
        self.interactor = Interactor(appstate)
    }
}

extension DIContainer {
    func Publish() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
}

struct Interactor {
    var usertask: UsertaskInteractor
    
    init(_ appstate: AppState) {
        self.usertask = UsertaskInteractor(appstate: appstate)
    }
}
