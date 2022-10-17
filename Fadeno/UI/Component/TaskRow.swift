import Foundation
import SwiftUI
import UIComponent

@MainActor
struct TaskRow: View {
    @EnvironmentObject private var container: DIContainer
    @Environment(\.openURL) private var openURL
    @State private var usertask: Usertask
    @State private var isPopover: Bool
    
    @State private var title: String = ""
    @State private var outline: String = ""
    @State private var content: String = ""
    @State private var complete = false
    
    @State private var detail = false
    @State private var linked = false
    
    /* timer */
    @State private var timer: CacheTimer?
    
    init(usertask: Usertask, isNew: Bool, isPopover: Bool = false) {
        self._usertask = State(initialValue: usertask)
        self._isPopover = State(initialValue: isPopover)
        self._complete = State(initialValue: usertask.complete)
        self.timer = nil
        
        if !isNew {
            self._title = State(initialValue: usertask.title)
            self._outline = State(initialValue: usertask.outline)
            self._content = State(initialValue: usertask.content)
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .foregroundColor(usertask.type.color)
                .frame(width: 5)
                .padding(.vertical, 1)
                .opacity(complete ? 0.2 : 1)
            DebugBlock
            VStack(alignment: .leading, spacing: 0) {
                TitleRowBlock
                NoteRowBlock
            }
            Block(width: 5)
            CompleteBlock
            if isPopover {
                PopoverTrigerBlock
            } else {
                Block(width: 10, height: 10)
                ContentPageBlock
            }
        }
        .frame(height: isPopover ? 30 : 50)
        .lineLimit(1)
        .truncationMode(.tail)
        .background(.background)
        .onAppear {
            linked = IsLink(outline)
            if timer != nil {
                return
            }
            timer = CacheTimer(countdown: 20, timeInterval: 0.1, action: {
                print("usertask saved, \(usertask.title)")
                container.interactor.usertask.UpdateUsertask(usertask)
                container.Publish()
            })
            timer?.Init()
        }
    }
}

// MARK: View Block

extension TaskRow {
    var DebugBlock: some View {
        Block(width: 20, height: 20, color: .gray)
            .overlay {
                Text(usertask.order.description)
            }
    }
    
    var TitleRowBlock: some View {
        HStack(spacing: 0) {
            Block(width: 5)
            
            TextField("Title...", text: Binding(
                get: {
                    title
                }, set: { value in
                    title = value
                    usertask.title = title
                    timer?.Refresh()
                }))
                .font(.system(size: 14, weight: .light, design: .default))
                .lineLimit(1)
                .textFieldStyle(.plain)
                .disabled(complete)
            
            Spacer()
        }
    }
    
    var NoteRowBlock: some View {
        HStack(spacing: 0) {
            Block(width: 5)
            
            if linked {
                ButtonCustom(width: 30, height: 11, color: .primary25, radius: 1) {
                    let str = usertask.outline.split(separator: " ").first(where: { $0.contains("https://") })
                    guard let separated = str?.split(separator: "/", maxSplits: 1, omittingEmptySubsequences: true) else { return }
                    if separated.isEmpty { return }
                    guard var component = URLComponents(string: separated[0].description) else { return }
                    if separated.count > 0 {
                        component.path = separated[1].description
                    }
                    if let url = component.url {
                        openURL(url)
                    }
                } content: {
                    Text("link")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                }
                .padding(.trailing, 5)
            }

            TextField("Link or Description...", text: Binding(
                get: {
                    outline
                }, set: { value in
                    outline = value
                    usertask.outline = outline
                    linked = IsLink(value)
                    timer?.Refresh()
                }))
                .foregroundColor(.primary75)
                .font(.system(size: 10, weight: .thin, design: .default))
                .frame(height: 10)
                .lineLimit(1)
                .textFieldStyle(.plain)
                .disabled(complete)
        }
    }
    
    var CompleteBlock: some View {
        ButtonCustom(width: 25, height: 25, radius: 5) {
            withAnimation {
                complete.toggle()
                usertask.complete = complete
                container.interactor.usertask.UpdateUsertask(usertask)
                container.Publish()
            }
        } content: {
            Image(systemName: complete ? "checkmark.circle.fill" : "circle")
                .font(.title3)
                .foregroundColor(.primary50.opacity( complete ? 0.3 : 0.75))
        }
    }
    
    var PopoverTrigerBlock: some View {
        ButtonCustom(width: 25, height: 25, radius: 5) {
            if container.appstate.usersetting.popoverClick {
                detail = true
            }
        } content: {
            Image(systemName: content.isEmpty ?  "bubble.middle.bottom" : "bubble.middle.bottom.fill")
                .foregroundColor(.primary50.opacity( complete ? 0.3 : 0.75))
        }
        .onHover(perform: { value in
            if container.appstate.userdata.page == -1 {
                detail = false
                return
            }
            
            if container.appstate.usersetting.popoverClick {
                detail = detail
                return
            }
            
            if container.appstate.usersetting.popoverAutoClose {
                detail = value
                return
            }
            detail = true
            
        })
        .popover(isPresented: $detail, arrowEdge: .trailing) {
            ZStack {
                TextEditor(text: complete ? .constant(content) : Binding(
                    get: {
                        content
                    }, set: { value in
                        content = value
                        if usertask.content != value {
                            usertask.content = value
                            #if DEBUG
                            print("Changed!")
                            #endif
                        }
                    }))
                    .font(.system(size: 14, weight: .thin, design: .default))
                    .background(.clear)
                    .frame(width: CGFloat(container.appstate.usersetting.popoverWidth),
                           height: CGFloat((content.filter { $0 == "\n" }.count+1) * (14+3)),
                           alignment: .leading)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
    }
    
    var ContentPageBlock: some View {
        ButtonCustom(width: 25, height: 25, color: container.appstate.userdata.currentTask.id == usertask.id ? .blue : .transparent, radius: 3) {
            withAnimation {
                container.appstate.userdata.currentTask = usertask
                container.Publish()
            }
        } content: {
            Image(systemName: "chevron.right")
                .font(.title2)
                .foregroundColor(container.appstate.userdata.currentTask.id == usertask.id ? .white : .primary50.opacity( complete ? 0.3 : 0.75))
        }

    }
}

// MARK: Function

extension TaskRow {
    func IsLink(_ str: String) -> Bool {
        str.contains("https://")
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Row(Usertask.preview.urgent)
            Row(Usertask.preview.archive)
            Row(Usertask.preview.normal)
            Row(Usertask.preview.todo)
        }
        .frame(width: 300)
        .padding()
        .preferredColorScheme(.light)
        .background(.background)
        
        VStack {
            Row(Usertask.preview.urgent)
            Row(Usertask.preview.archive)
            Row(Usertask.preview.normal)
            Row(Usertask.preview.todo)
        }
        .frame(width: 300)
        .padding()
        .preferredColorScheme(.dark)
        .background(.background)
    }
    
    @MainActor
    static func Row(_ task: Usertask) -> some View {
        TaskRow(usertask: task, isNew: false)
        .environment(\.locale, .US)
        .inject(DIContainer.preview)
    }
}
