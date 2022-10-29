//
//  TaskListView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/17.
//

import SwiftUI
import UIComponent

struct MultipleTaskListView: View {
    @EnvironmentObject private var container: DIContainer
    @State var currentTask: Usertask? = nil
    @State var searchText: String = ""
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                SearchBlock(text: $searchText)
                    .padding(.vertical, 10)
                GeometryReader { proxy in
                    VStack(spacing: 0) {
                        ForEach(Usertask.Tasktype.allCases) { type in
                            switch type {
                            case .urgent, .normal, .todo: //, .custom:
                                Separator(color: .section)
                                    .padding(.vertical, 5)
                                TaskBlock(type: type, searchText: $searchText, less: { $0.order < $1.order })
                            default:
                                EmptyView()
                            }
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 10)
            .background(.background)
            .frame(width: 400)
            Separator(direction: .vertical, color: .section, size: 1)
            MarkdownContent(mdView: Markdown(currentTask?.content ?? "").id(currentTask?.hashID ?? ""))
        }
        .onReceive(container.appstate.userdata.currentTask) { value in
            currentTask = value
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleTaskListView()
            .inject(DIContainer.preview)
    }
}
