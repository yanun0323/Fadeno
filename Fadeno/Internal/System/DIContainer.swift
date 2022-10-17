import Foundation

class DIContainer: ObservableObject {
    var appState: AppState {
        willSet {
            objectWillChange.send()
        }
    }
    var interactor: Interactor
    
    init(appState: AppState) {
        self.appState = appState
        self.interactor = Interactor(appState)
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
    var usertaskInteractor: UsertaskInteractor
    
    init(_ appState: AppState) {
        self.usertaskInteractor = UsertaskInteractor(appState: appState)
    }
}
