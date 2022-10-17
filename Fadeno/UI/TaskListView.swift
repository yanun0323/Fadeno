//
//  TaskListView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/17.
//

import SwiftUI
import UIComponent

struct TaskListView: View {
    @EnvironmentObject private var container: DIContainer
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                SearchBlock()
                    .padding(.vertical, 10)
                Separator(color: .section)
                VStack(spacing: 0) {
                    ForEach(Usertask.Tasktype.allCases) { type in
                        switch type {
                        case .urgent, .normal, .todo, .custom:
                            TaskBlock(type: type)
                                .frame(height: 150)
                            Separator(color: .section)
                                .padding(.vertical, 5)
                        default:
                            EmptyView()
                        }
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
            .background(.background)
            .frame(maxWidth: 400)
            Separator(direction: .vertical, color: .section, size: 1)
            MarkdownContent(mdView: Markdown(container.appState.userdata.currentTask.content).id(Date.now))
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .inject(DIContainer.preview)
    }
}
