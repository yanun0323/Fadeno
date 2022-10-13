import Foundation

class DIContainer: ObservableObject {
    @Published var appState: AppState
    @Published var interactor: Interactor
    
    init(appState: AppState, interactor: Interactor) {
        self.appState = appState
        self.interactor = interactor
    }
}
