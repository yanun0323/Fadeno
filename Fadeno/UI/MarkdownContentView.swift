import SwiftUI
import UIComponent

struct MarkdownContentView<V>: View where V: View{
    @EnvironmentObject var container: DIContainer
    @FocusState var focus: Bool
    @State var edit: Bool = false
    @State var mdView: V
    
    var body: some View {
        mainView
        .padding()
        .onChange(of: self.focus) { newValue in
            if !newValue {
                self.edit = false
            }
        }
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
        .onReceive(container.appState.shared.$currentTask) { publiser in
            mdView = Markdown(publiser.content, .dark).id(Date.now) as! V
            print("receive \(publiser.title)")
        }
    }
}

// MARK: View
extension MarkdownContentView {
    var mainView: some View {
        ZStack {
            TextEditor(text: $container.appState.shared.currentTask.content)
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
        MarkdownContentView(mdView: Markdown(UserTask.preview.todo.content, .dark).id(Date.now))
            .inject(DIContainer.preview)
    }
}
