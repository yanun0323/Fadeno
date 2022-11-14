//
//  SingleTaskListView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/27.
//

import SwiftUI
import UIComponent

struct SingleTaskListView: View {
    @EnvironmentObject private var container: DIContainer
    @State var currentTask: Usertask? = nil
    @State var searchText: String = ""
    
    let type: Usertask.Tasktype
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                SearchBlock(text: $searchText)
                    .padding(.vertical, 10)
                Separator(color: .section)
                    .padding(.vertical, 5)
                TaskBlock(type: type, searchText: $searchText, less: { $0.order < $1.order }, isSingle: true)
            }
            .padding(.horizontal, 10)
            .background()
            .frame(width: 400)
            Separator(direction: .vertical, color: .section, size: 1)
            MarkdownContent() // mdView: Markdown(currentTask?.content ?? "").id(currentTask?.hashID ?? "")
        }
        .onReceive(container.appstate.userdata.currentTask) { value in
            currentTask = value
        }
    }
}

struct SingleTaskListView_Previews: PreviewProvider {
    static var previews: some View {
        SingleTaskListView(type: .archived)
            .inject(DIContainer.preview)
    }
}
