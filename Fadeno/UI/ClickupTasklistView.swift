//
//  ClickupTasklistView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/11/1.
//

import SwiftUI
import UIComponent

struct ClickupTasklistView: View {
    @EnvironmentObject private var container: DIContainer
    @State private var tasks: [Clickup.Task] = []
    @State private var isLoading = false
    @State private var isPopup = false
    @State private var PopupTaskID = ""
    var body: some View {
        ZStack {
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
            .disabled(isPopup)
            .blur(radius: isPopup ? 10 : 0)
            .opacity(isPopup ? 0.5 : 1)
            .colorMultiply(isPopup ? .gray : .white)
            
            ZStack {
                if isPopup {
                    ClickupTaskView(open: $isPopup, taskID: PopupTaskID)
                        .cornerRadius(5)
                        .shadow(radius: 3)
                        .padding(30)
                }
            }
        }
        .background()
        .onReceive(container.appstate.clickup.tasks) { value in
            withAnimation {
                isLoading = false
                tasks = value.sorted(by: { $0.status.orderindex < $1.status.orderindex })
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
extension ClickupTasklistView {
    var TasksBlock: some View {
        List {
            ForEach(tasks, id: \.self.id) { task in
                ClickupTaskRow(task: task)
                    .onTapGesture {
                        if task.id.isEmpty {
                            return
                        }
                        withAnimation {
                            PopupTaskID = task.id
                            isPopup = true
                        }
                    }
            }
            .listRowBackground(Color.transparent)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
    }
}

struct ClickupTasklistView_Previews: PreviewProvider {
    static var previews: some View {
        ClickupTasklistView()
            .frame(width: 1200)
            .inject(DIContainer.preview)
    }
}
