import SwiftUI
import UIComponent

struct HomeView: View {
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                SearchBlock()
                    .padding(.vertical, 10)
                VStack(spacing: 0) {
                    ForEach(container.appState.shared.tasks) { task in
                        TaskRow(userTask: task, title: task.title, outline: task.outline, content: task.content, isPopover: false)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
            .background(.background)
            Separator(direction: .vertical, color: .section, size: 1)
            MarkdownContentView(mdView: Markdown(container.appState.shared.currentTask.content).id(Date.now))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .inject(DIContainer.preview)
    }
}
