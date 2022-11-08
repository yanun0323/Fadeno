//
//  ClickupTaskView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/11/8.
//

import SwiftUI
import UIComponent

struct ClickupTaskView: View {
    @EnvironmentObject private var container: DIContainer
    @State var task: Clickup.Task? = nil
    @State var isLoading = false
    @Binding var open: Bool
    @State var taskID: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                ButtonCustom(width: 23, height: 23, color: .white, radius: 5, shadow: 1.2) {
                    withAnimation {
                        open = false
                    }
                } content: {
                    Image(systemName: "multiply")
                        .font(.title3)
                        .foregroundColor(.primary50)
                }
                .padding(.vertical, 3)
                .padding(.trailing, 5)
            }
            .background(Color.section)
            
            if isLoading {
                Block()
                    .overlay {
                        VStack {
                            LoadingCircle(color: .gray, size: 30, lineWidth: 3, speed: 1.5)
                                .padding()
                                .transition(.opacity)
                            Text("Loading...")
                                .foregroundColor(.gray)
                                .transition(.opacity)
                        }
                    }
            } else if task == nil {
                Block()
                    .overlay {
                        Text("clickup.task.error")
                    }
            } else {
                TaskBlock
            }
        }
        .background()
        .onReceive(container.appstate.clickup.currentTask) { value in
            withAnimation {
                task = value
                isLoading = false
            }
        }
        .onAppear {
            isLoading = true
            container.interactor.clickup.GetTask(taskID)
        }
    }
}

extension ClickupTaskView {
    var TaskBlock: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitleInfoBlock
                .padding(.horizontal)
                .padding(.vertical, 5)
            Separator(color: .section)
            HStack(spacing: 0) {
                ContentBlock
                    .padding()
                Block(color: .section)
            }
        }
    }
    
    var TitleInfoBlock: some View {
        HStack(spacing: 30) {
            ButtonCustom(width: 70, height: 28, color: .init(hex: task!.status.color), radius: 5) {
            } content: {
                Text(task!.status.status.uppercased())
                    .font(.callout)
            }
            AssigneesBlock
            
            Circle()
                .stroke(Color.init(hex: task?.priority?.color), style: StrokeStyle(lineWidth: 1))
                .frame(width: 28, height: 28)
                .overlay {
                    Image(systemName: "flag.fill")
                        .foregroundColor(Color.init(hex: task?.priority?.color))
                }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.primary50, style: StrokeStyle(lineWidth: 1))
                .frame(width: 60, height: 20)
                .overlay {
                    Text(task!.customID ?? task!.id)
                        .font(.caption2)
                        .kerning(-0.75)
                        .foregroundColor(Color.primary50)
                }
            
        }
    }
    
    var AssigneesBlock: some View {
        HStack(spacing: -7) {
            ForEach(task!.assignees.indices, id: \.self) { i in
                ZStack {
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.init(hex: task!.assignees[i].color))
                    Text(task!.assignees[i].username?.first?.uppercased() ?? "-")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                }
                .frame(width: 28, height: 28)
                .background()
                .clipShape(Circle())
                .zIndex(Tool.IntToDouble(10-i))
            }
        }
    }
    
    var ContentBlock: some View {
        VStack(alignment: .leading) {
            Text(task?.name ?? "-")
                .font(.title2)
            Markdown(task?.textContent ?? "-")
        }
    }
}

struct ClickupTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ClickupTaskView(open: .constant(true), taskID: "3qtufv4")
            .inject(DIContainer.preview)
    }
}
