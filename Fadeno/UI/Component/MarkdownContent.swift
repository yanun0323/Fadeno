import SwiftUI
import UIComponent

struct MarkdownContent<V>: View where V: View{
    @EnvironmentObject private var container: DIContainer
    @FocusState private var focus: Bool
    @State private var edit: Bool = false
    @State var mdView: V
    
    var body: some View {
        VStack {
//            titleBlock
//            Separator()
            mdBlock
        }
        .padding()
        .hotkey(key: .kVK_Escape, keyBase: []) {
            if edit {
                edit = false
                focus = false
            }
        }
        .hotkey(key: .kVK_Return, keyBase: []) {
            if !edit {
                edit = true
                focus = true
            }
        }
        .onChange(of: self.focus) { newValue in
            if !newValue {
                self.edit = false
            }
        }
        .onReceive(container.objectWillChange) { _ in
            mdView = Markdown(container.appState.userdata.currentTask.content, .dark).id(Date.now) as! V
        }
    }
}

// MARK: View
extension MarkdownContent {
    var titleBlock: some View {
        HStack {
            Block(width: 5, height: 30, color: container.appState.userdata.currentTask.type.color)
            Text(container.appState.userdata.currentTask.title)
                .font(.title)
            Spacer()
        }
    }
    
    var mdBlock: some View {
        ZStack {
            TextEditor(text: $container.appState.userdata.currentTask.content)
                .font(.title3)
                .focused($focus)
                .opacity(edit ? 1 : 0)
                .disabled(!focus)
            
            if !edit {
                mdView
            }
        }
    }
}

struct MarkdownTestView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownContent(mdView: Markdown(Usertask.preview.todo.content, .dark).id(Date.now))
            .inject(DIContainer.preview)
    }
}
