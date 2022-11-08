import SwiftUI
import UIComponent

struct MarkdownContent<V: View>: View {
    @EnvironmentObject private var container: DIContainer
    @FocusState private var focus: Bool
    @State private var edit: Bool = false
    @State private var currentTask: Usertask? = nil
    @State private var input = ""
    @State var mdView: V
    
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
        .onChange(of: focus) { value in
            if !value {
                edit = false
            }
        }
        .onChange(of: input) { value in
            currentTask?.content = value
            if let current = currentTask {
                container.interactor.usertask.UpdateUsertask(current)
            }
        }
        .onReceive(container.appstate.markdown.focus) { value in
            focus = value
        }
        .onReceive(container.appstate.userdata.currentTask) { value in
            currentTask = value
            input = currentTask?.content ?? ""
            mdView = Markdown(currentTask?.content ?? "", .dark).id(currentTask?.hashID ?? "") as! V
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
        .background()
        .cornerRadius(7)
        .shadow(color: .black.opacity(0.5), radius: 2, y: 1)
    }
    
    var mdBlock: some View {
        ZStack {
            if currentTask != nil {
                TextEditor(text: $input)
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
