import Foundation
import SwiftUI
import UIComponent

struct TaskRow: View {
    @EnvironmentObject private var container: DIContainer
    @Environment(\.openURL) private var openURL
    @Binding private var usertask: Usertask
    @Binding private var currentID: UUID
    @Binding private var searched: Bool
    @State private var isPopover: Bool
    
    @State private var title: String
    @State private var outline: String
    @State private var content: String
    
    @State private var detail = false
    @State private var linked = false
    
    /* timer */
    @State private var timer: CacheTimer?
    
    var cacheTask: Usertask {
        return usertask
    }
    
    init(usertask: Binding<Usertask>, currentID: Binding<UUID>, searched: Binding<Bool>, isPopover: Bool = false) {
        self._usertask = usertask
        self._currentID = currentID
        self._searched = searched
        self._isPopover = State(initialValue: isPopover)
        self._title = State(initialValue: usertask.wrappedValue.title)
        self._outline = State(initialValue: usertask.wrappedValue.outline)
        self._content = State(initialValue: usertask.wrappedValue.content)
        self.timer = nil
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                if searched {
                    VStack {
                        Circle()
                            .foregroundColor(usertask.type.color)
                            .frame(width: 5, height: 5)
                        Circle()
                            .foregroundColor(usertask.type.color)
                            .frame(width: 5, height: 5)
                        Circle()
                            .foregroundColor(usertask.type.color)
                            .frame(width: 5, height: 5)
                        
                    }
                } else {
                    Rectangle()
                        .foregroundColor(usertask.type.color)
                        .frame(width: 5)
                        .padding(.vertical, 1)
                }
                VStack(alignment: .leading, spacing: 0) {
                    TitleRowBlock
                    NoteRowBlock
                }
                Block(width: 5)
                if isPopover {
                    PopoverTrigerBlock
                } else {
                    Block(width: 10, height: 10)
                    ContentPageBlock
                }
            }
            .padding(5)
            .background(BackgroundStyle.background)
            .colorMultiply((currentID == usertask.id && !isPopover) ? .cyan.opacity(0.8) : .white)
            .cornerRadius(isPopover ? 0 : 5)
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
            timer = CacheTimer(countdown: 3, timeInterval: 0.1, action: {
                print("usertask saved, \(usertask.title)")
                container.interactor.usertask.UpdateUsertask(cacheTask)
            })
            timer?.Init()
        }
        .onReceive(container.appstate.userdata.tasks) { _ in
            guard let task = container.interactor.usertask.GetUsertask(usertask.id) else { return }
            usertask = task
            UpdateSelf()
            timer?.SkipAction()
        }
    }
}

// MARK: View Block

extension TaskRow {
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
        }
    }
    
    var PopoverTrigerBlock: some View {
        ButtonCustom(width: 25, height: 25, radius: 5) {
//            if container.appstate.usersetting.popoverClick {
//                detail = true
//            }
        } content: {
            Image(systemName: content.isEmpty ?  "bubble.middle.bottom" : "bubble.middle.bottom.fill")
                .foregroundColor(.primary25)
        }
        .onHover(perform: { value in
            if container.appstate.userdata.page == -1 {
                detail = false
                return
            }
            
//            if container.appstate.usersetting.popoverClick {
//                detail = detail
//                return
//            }
            
//            if container.appstate.usersetting.popoverAutoClose {
//                detail = value
//                return
//            }
            detail = true
            
        })
        .popover(isPresented: $detail, arrowEdge: .trailing) {
            ZStack {
                TextEditor(text: Binding(
                    get: {
                        content
                    }, set: { value in
                        content = value
                        if usertask.content != value {
                            usertask.content = value
                        }
                    }))
                    .font(.system(size: 14, weight: .thin, design: .default))
                    .background(.clear)
//                    .frame(width: CGFloat(container.appstate.usersetting.popoverWidth),
//                           height: CGFloat((content.filter { $0 == "\n" }.count+1) * (14+3)),
//                           alignment: .leading)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
    }
    
    var ContentPageBlock: some View {
        ButtonCustom(width: 25, height: 25) {
            withAnimation {
                container.interactor.usertask.SetCurrentUsertask(usertask)
                container.interactor.tasklist.ResetMarkdownFocus()
            }
        } content: {
            Image(systemName: "chevron.right")
                .font(.title2)
                .foregroundColor(.primary50.opacity(0.75))
        }

    }
}

// MARK: Function

extension TaskRow {
    func IsLink(_ str: String) -> Bool {
        str.contains("https://")
    }
    
    func UpdateSelf() {
        title = usertask.title
        outline = usertask.outline
        content = usertask.content
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            Row(Usertask.preview.urgent)
            Row(Usertask.preview.archive)
            Row(Usertask.preview.normal)
            Row(Usertask.preview.todo)
        }
        .frame(width: 300)
        .padding()
        .preferredColorScheme(.light)
        .background(.background)
        
        VStack(spacing: 0) {
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
        TaskRow(usertask: .constant(task), currentID: .constant(UUID()), searched: .constant(true))
        .environment(\.locale, .US)
        .inject(DIContainer.preview)
    }
}
