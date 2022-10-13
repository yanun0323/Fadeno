import SwiftUI

protocol NSGlobalInteractor {
}

struct GlobalInteractor {
    var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
}

extension GlobalInteractor: NSGlobalInteractor {
}
