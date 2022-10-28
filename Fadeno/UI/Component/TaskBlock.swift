//
//  TasktypeBlock.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/12.
//

import SwiftUI
import UIComponent

struct TaskBlock: View {
    @EnvironmentObject var container: DIContainer
    @Environment(\.locale) private var locale
    @State var tasks: [Usertask] = []
    
    @State private var hovered: Bool = false
    
    let type: Usertask.Tasktype
    @Binding var searchText: String
    let less: (Usertask,Usertask) -> Bool
    var isSingle: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            if !isSingle {
                LeftbarBlock
            }
            TaskListBlock
        }
        .onReceive(container.appstate.userdata.tasks) { value in
            tasks = container.interactor.usertask.SearchHandler(searchText, value.filter({ $0.type == self.type })).sorted(by: { less($0,$1) })
        }
        .onAppear {
            container.interactor.usertask.Publish()
        }
    }
}

// MARK: Property
extension TaskBlock {
    var count: Double {
        var c: Double = 4
//        if container.appstate.usersetting.hideBlock { c = 3 }
//        if container.appstate.usersetting.hideEmergency { c = 2 }
        return c
    }
}

// MARK: SubView
extension TaskBlock {
    var TopbarBlock: some View {
        HStack(spacing: 5) {
            if locale.description.split(separator: "_")[0].contains("en") {
                VStack(alignment: .leading, spacing: 0) {
                    Text(type.title)
                        .font(.title)
                        .fontWeight(.thin)
                        .foregroundColor(.primary75)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .fixedSize()
                        .rotationEffect(Angle(degrees: 90), anchor: .bottomLeading)
                        .multilineTextAlignment(.leading)
                        .offset(x: 0, y: -25)
                }
                .frame(height: 25)
                .clipped()
            } else {
                Text(type.title)
                    .font(.title)
                    .fontWeight(.thin)
                    .frame(width: 25)
                    .minimumScaleFactor(1)
            }
            Spacer()
            CountAndCreaterBlock
        }
        .background(.background)
        .zIndex(2)
    }
    var LeftbarBlock: some View {
        VStack(spacing: 5) {
            if locale.description.split(separator: "_")[0].contains("en") {
                VStack(alignment: .leading, spacing: 0) {
                    Text(type.title)
                        .font(.title)
                        .fontWeight(.thin)
                        .foregroundColor(.primary75)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .fixedSize()
                        .frame(height: 25)
                        .rotationEffect(Angle(degrees: 90), anchor: .bottomLeading)
                        .multilineTextAlignment(.leading)
                        .offset(x: 0, y: -25)
                }
                .frame(
                    width: 25, // height: container.appstate.usersetting.windowsHeight/count - 65,
                    alignment: .topLeading
                )
                .clipped()
            } else {
                Text(type.title)
                    .font(.title)
                    .fontWeight(.thin)
                    .frame(width: 25)
                    .minimumScaleFactor(1)
            }
            Spacer()
            CountAndCreaterBlock
        }
        .background(.background)
        .zIndex(2)
    }
    
    var CountAndCreaterBlock: some View {
        ZStack {
            if hovered || tasks.isEmpty {
                CreateButton {
                    withAnimation {
                        let task = Usertask()
                        task.type = type
                        container.interactor.usertask.CreateUsertask(task)
                    }
                }
                .transition(.opacity)
            } else {
                CountBlock
                    .transition(.opacity)
            }
        }
        .onHover { hovered in
            withAnimation(Config.Animation.Default) {
                self.hovered = hovered
            }
        }
    }
    
    func CreateButton(action: @escaping () -> Void) -> some View  {
        ButtonCustom(width: 25, height: 22, action: action) {
            Text("+")
                .foregroundColor(type.color)
                .font(.title)
                .fontWeight(.thin)
                .frame(width: 25)
                .lineLimit(1)
        }
    }
    
    var CountBlock: some View {
        Text("\(tasks.count)")
            .foregroundColor(type.color)
            .font(.title2)
            .fontWeight(.thin)
            .frame(width: 25)
            .lineLimit(1)
    }
    
    var TaskListBlock: some View {
        ZStack {
            List {
                if tasks.isEmpty {
                    ListEmptyBlock
                        .onInsert(of: ["UTType.SwiftUIReorderData"], perform: InserAction(_:_:))
                        .animation(.none, value: tasks)
                } else {
                    ListExistBlock
                        .onInsert(of: ["UTType.SwiftUIReorderData"], perform: InserAction(_:_:))
                        .animation(.none, value: tasks)
                }
            }
            .listStyle(.plain)
            .background(.clear)
        }
    }
    
    var ListExistBlock: some DynamicViewContent {
        ForEach(tasks) { task in
            TaskRow(usertask: .constant(task)).id(task.hashID)
                .transition(.opacity)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .onDrag {
                    return NSItemProvider(object: SwiftUIListReorder(task))
                } preview: {
                    HStack {
                        Rectangle()
                            .foregroundColor(type.color)
                            .frame(width: 3)
                        Text(task.title)
                            .font(.title)
                            .fontWeight(.light)
                        Spacer()
                    }
                    .background(.background)
                }
                .contextMenu {
                    Button("Archive Task") {
                        withAnimation(Config.Animation.Default) {
                            if container.interactor.usertask.GetCurrentUsertask()?.id == task.id {
                                container.interactor.usertask.SetCurrentUsertask(nil)
                            }
                            container.interactor.usertask.MoveUserTask(task, toType: .archived)
                        }
                    }.disabled(task.isArchived)
                    
                    Button("Move To Todo") {
                        withAnimation(Config.Animation.Default) {
                            if container.interactor.usertask.GetCurrentUsertask()?.id == task.id {
                                container.interactor.usertask.SetCurrentUsertask(nil)
                            }
                            container.interactor.usertask.MoveUserTask(task, toType: .todo)
                        }
                    }.disabled(!task.isArchived)
                    
                    if task.isComplete {
                        Button("Delete Task", role: .destructive) {
                            withAnimation(Config.Animation.Default) {
                                if container.interactor.usertask.GetCurrentUsertask()?.id == task.id {
                                    container.interactor.usertask.SetCurrentUsertask(nil)
                                }
                                container.interactor.usertask.DeleteUsertask(task)
                            }
                        }
                    } else {
                        Button("Complete Task", role: .destructive) {
                            withAnimation(Config.Animation.Default) {
                                if container.interactor.usertask.GetCurrentUsertask()?.id == task.id {
                                    container.interactor.usertask.SetCurrentUsertask(nil)
                                }
                                container.interactor.usertask.MoveUserTask(task, toType: .complete)
                            }
                        }
                    }
                }
        }
    }
    
    var ListEmptyBlock: some DynamicViewContent {
        ForEach(0...0, id: \.self) { text in
            HStack {
                Spacer()
                Text("No task here")
                    .font(.title2)
                    .fontWeight(.ultraLight)
                    .foregroundColor(.primary25)
                Spacer()
            }
        }
    }
}

// MARK: Function
extension TaskBlock {
    func InserAction(_ index: Int, _ providers: [NSItemProvider]) -> Void {
        for item in providers {
            item.loadObject(ofClass: SwiftUIListReorder.self) { recorder, error in
                if let error = error {
                    print(error)
                }
                guard let recorder = recorder as? SwiftUIListReorder else { return }
                var destination = index
                if recorder.usertask.type == type && destination > recorder.usertask.order {
                    destination -= 1
                }
                if tasks.isEmpty {
                    destination = 0
                }
                
                container.interactor.usertask.MoveUserTask(
                    recorder.usertask,
                    toOrder: destination,
                    toType: type
                )
            }
        }
    }
}

struct TasktypeBlock_Previews: PreviewProvider {
    static var previews: some View {
        TaskBlock(tasks: [.preview.urgent, .preview.urgent1], type: .todo, searchText: .constant(""), less: {$0.order < $1.order})
            .inject(DIContainer.preview)
    }
}
