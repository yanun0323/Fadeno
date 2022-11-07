//
//  ClickupMyTaskView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/11/1.
//

import SwiftUI
import UIComponent

struct ClickupMyTaskView: View {
    @EnvironmentObject private var container: DIContainer
    @State private var tasks: [Clickup.Task] = []
    @State private var isLoading = false
    var body: some View {
        VStack {
            if isLoading {
                Block()
                LoadingCircle(color: .gray, size: 30, lineWidth: 3, speed: 1.5)
                    .padding()
                    .transition(.opacity)
                Text("Loading...")
                    .foregroundColor(.gray)
                    .transition(.opacity)
                Block()
            } else {
                HStack {
                    Text("STATUS")
                        .font(.subheadline)
                        .frame(width: 150)
                    Text("TASK")
                        .font(.subheadline)
                        .padding(.leading, 20)
                        .frame(alignment: .leading)
                    Spacer()
                    Text("TAG")
                        .font(.subheadline)
                        .frame(width: 170, alignment: .leading)
                    Text("PRIORITY")
                        .font(.subheadline)
                        .frame(width: 100)
                    Text("ASSIGNEE")
                        .font(.subheadline)
                        .frame(width: 120)
                }
                .foregroundColor(.gray)
                .frame(height: 10)
                .padding([.horizontal, .top], 10)
                .transition(.opacity)
                TasksBlock
                    .transition(.opacity)
            }
        }
        .background(.background)
        .onReceive(container.appstate.clickup.tasks) { value in
            withAnimation {
                isLoading = false
                tasks = value.sorted(by: { $0.status?.orderindex ?? 0 < $1.status?.orderindex ?? 0})
            }
        }
        .onAppear {
            withAnimation {
                isLoading = true
                container.interactor.clickup.ListTaks()
            }
        }
        .hotkey(key: .kVK_ANSI_R, keyBase: [.command]) {
            withAnimation {
                if !isLoading {
                    isLoading = true
                    container.interactor.clickup.ListTaks()
                }
            }
        }
    }
}

// MARK: - View Block
extension ClickupMyTaskView {
    var TasksBlock: some View {
        List {
            ForEach(tasks, id: \.self.id) { task in
                ClickupTaskRow(task: task)
            }
            .listRowBackground(Color.transparent)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
    }
}

struct ClickupMyTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ClickupMyTaskView()
            .frame(width: 1200)
            .inject(DIContainer.preview)
    }
}
