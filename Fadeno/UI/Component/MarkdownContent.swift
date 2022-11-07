import SwiftUI
import UIComponent

struct MarkdownContent<V>: View where V: View {
    @EnvironmentObject private var container: DIContainer
    @FocusState var focus: Bool
    @State var edit: Bool = false
    @State var mdView: V
    @State var currentTask: Usertask? = nil
    @State var timer: CacheTimer? = nil
    
    var cacheTask: Usertask? {
        return currentTask
    }
    
    var body: some View {
        VStack {
            if currentTask != nil {
                infoBlock
            }
            mdBlock
        }
        .padding()
        .background(edit ? Color.section : Color.transparent)
        .hotkey(key: .kVK_Return, keyBase: [.command]) {
            ToggleMode()
        }
        .hotkey(key: .kVK_Return, keyBase: []) {
            EditMode()
        }
        .onChange(of: focus) { newValue in
            if !newValue {
                edit = false
            }
        }
        .onReceive(container.appstate.markdown.focus) { value in
            focus = value
        }
        .onReceive(container.appstate.userdata.currentTask) { value in
            currentTask = value
            timer?.SkipAction()
            mdView = Markdown(currentTask?.content ?? "", .dark).id(currentTask?.hashID ?? "") as! V
        }
        .onAppear {
            if timer != nil { return }
            timer = CacheTimer(countdown: 3, timeInterval: 0.1, action: {
                if cacheTask != nil {
                    container.interactor.usertask.UpdateUsertask(cacheTask!)
                }
            })
            timer?.Activate()
        }
    }
}

// MARK: View
extension MarkdownContent {
    var infoBlock: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(edit ? "markdown.mode.edit" : "markdown.mode.view")
                    .foregroundColor(edit ? .accentColor : nil)
                Text(edit ? "markdown.mode.toggle.view" : "markdown.mode.toggle.edit")
                    .foregroundColor(.gray)
                    .font(.caption)
                    .animation(.none, value: edit)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    Text("markdown.lastupdate")
                    Text(currentTask!.updateTime.String("YYYY.MM.dd EE  HH:mm:ss", .current))
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .monospacedDigit()
                }
            }
        }
        .padding()
        .frame(height: 40)
        .background(.background)
        .cornerRadius(7)
        .shadow(color: .black.opacity(0.5), radius: 2, y: 1)
    }
    
    var mdBlock: some View {
        ZStack {
            if currentTask != nil {
                TextEditorView(text: Binding(get: {
                    currentTask!.content
                }, set: { value in
                    currentTask!.content = value
                    timer?.Refresh()
                }))
                    .font(.title3)
                    .focused($focus)
                    .opacity(edit ? 1 : 0)
                    .disabled(!focus)
                    .padding()
            }
            
            if currentTask == nil || !edit {
                mdView
                    .transition(.opacity)
            }
        }
    }
}

extension MarkdownContent {
    func EditMode() {
        withAnimation {
            if currentTask != nil && !edit {
                edit = true
                focus = edit
            }
        }
    }
    
    func ViewMode() {
        withAnimation {
            if currentTask != nil && edit {
                edit = false
                focus = edit
            }
        }
    }
    
    func ToggleMode() {
        withAnimation {
            if currentTask != nil {
                edit.toggle()
                focus = edit
            }
        }
    }
}

struct MarkdownTestView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownContent(mdView: Markdown(Usertask.preview.todo.content, .dark).id(Usertask.preview.todo.hashID))
            .inject(DIContainer.preview)
            .frame(minWidth: 500, minHeight: 1000)
    }
}
