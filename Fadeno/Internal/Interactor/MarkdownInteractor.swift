//
//  TaskListInteractor.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/26.
//

import Foundation

class MarkdownInteractor {
    private var appstate: AppState
    
    init(appstate: AppState) {
        self.appstate = appstate
    }
}

extension MarkdownInteractor {
    func ResetMarkdownFocus() {
        appstate.markdown.focus.send(false)
    }
}
