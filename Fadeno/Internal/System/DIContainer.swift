//
//  DIContainer.swift
//  Fadeno
//
//  Created by YanunYang on 2022/9/21.
//

import Foundation

class DIContainer: ObservableObject {
    @Published var appState = AppState()
    var interactor = Interactor()
}

extension DIContainer {
    class AppState: ObservableObject {
        
    }
}

extension DIContainer {
    class Interactor {
        
    }
}
