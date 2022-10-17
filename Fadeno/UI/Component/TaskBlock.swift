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
    
    @State private var hovered: Bool = false
    
    var tasks: [Usertask] {
        self.container.appstate.userdata.tasks.filter({ $0.type == self.type }).sorted(by: { $0.order < $1.order })
    }
    
    let type: Usertask.Tasktype
    var body: some View {
        HStack(spacing: 0) {
            LeftbarBlock
            TaskListBlock
        }
    }
}

// MARK: Property
extension TaskBlock {
    var count: Double {
        var c: Double = 4
        if container.appstate.usersetting.hideBlock { c = 3 }
        if container.appstate.usersetting.hideEmergency { c = 2 }
        return c
    }
}

// MARK: SubView
extension TaskBlock {
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
                    width: 25,
                    height: container.appstate.usersetting.windowsHeight/count - 65,
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
//                    CreateAction()
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
            .transition(.opacity)
            .listStyle(.plain)
            .background(.clear)
        }
        .animation(Config.Animation.Default, value: tasks.count)
    }
    
    var ListExistBlock: some DynamicViewContent {
        ForEach(tasks) { task in
            TaskRow(usertask: task, isNew: false)
                .onDrag {
                    return NSItemProvider(object: SwiftUIListReorder(task))
                } preview: {
                    HStack {
                        Rectangle()
                            .foregroundColor(.accentColor)
                            .frame(width: 3)
                        Text(task.title)
                            .font(.body)
                            .fontWeight(.light)
                        Spacer()
                    }
                    .background(.background)
                }
                .contextMenu {
                    Button {
                        withAnimation(Config.Animation.Default) {
                            DispatchQueue.main.async {
                            }
                        }
                    } label: {
                        Text("Archive Task")
                    }
                    Button{
                        withAnimation(Config.Animation.Default) {
                            DispatchQueue.main.async {
//                                tasks.removeAll(where: { $0.id == task.id })
//                                DeleteFromDatabase(task)
                            }
                        }
                    } label: {
                        Text("Delete Task")
                            .foregroundColor(.red)
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
                if destination >= tasks.count {
                    destination = recorder.usertask.type == type ? tasks.count - 1 : tasks.count
                }
                print("move \(recorder.usertask.title) to \(destination)")
                
                container.interactor.usertask.RemoveUsertask(recorder.usertask)
                container.Publish()
                recorder.usertask.type = type
                recorder.usertask.order = destination
                container.interactor.usertask.InsertUsertask(recorder.usertask)
                container.Publish()
            }
        }
    }
}

struct TasktypeBlock_Previews: PreviewProvider {
    static var previews: some View {
        TaskBlock(type: .todo)
            .inject(DIContainer.preview)
    }
}
