import Foundation
import SwiftUI
import UIComponent

struct TaskRow: View {
    @EnvironmentObject private var container: DIContainer
    @Environment(\.openURL) private var openURL
    @Binding private var usertask: Usertask
    @Binding private var currentID: UUID
    @Binding private var searched: Bool
    
    @State private var title: String
    @State private var outline: String
    
    @State private var detail = false
    @State private var linked = false
    @State private var linkHover = false
    
    init(usertask: Binding<Usertask>, currentID: Binding<UUID>, searched: Binding<Bool>) {
        self._usertask = usertask
        self._currentID = currentID
        self._searched = searched
        self._title = State(initialValue: usertask.wrappedValue.title)
        self._outline = State(initialValue: usertask.wrappedValue.outline)
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
                    TitleBlock
                    OutlineBlock
                }
                
                ContentPageBlock
            }
            .padding(5)
            .background(BackgroundStyle.background)
            .colorMultiply(currentID == usertask.id ? .cyan.opacity(0.8) : .white)
            .cornerRadius(5)
        }
        .frame(height: 45)
        .lineLimit(1)
        .truncationMode(.tail)
        .background()
        .onAppear {
            linked = IsLink(outline)
        }
        .onReceive(container.appstate.userdata.tasks) { _ in
            print("Task Row \(usertask.type.title) \(usertask.order) recive tasks publish")
            guard let task = container.interactor.usertask.GetUsertask(usertask.id) else { return }
            usertask = task
            UpdateSelf()
        }
        .onChange(of: title) { value in
            usertask.title = value
            container.interactor.usertask.UpdateUsertask(usertask)
        }
        .onChange(of: outline) { value in
            usertask.outline = value
            linked = IsLink(value)
            container.interactor.usertask.UpdateUsertask(usertask)
        }
    }
}

// MARK: View Block

extension TaskRow {
    var TitleBlock: some View {
        HStack(spacing: 0) {
            Block(width: 5, height: 5)
            
            TextField("Title...", text: $title)
                .font(.system(size: 14, weight: (title.isEmpty ? .ultraLight : .light), design: .default))
                .lineLimit(1)
                .textFieldStyle(.plain)
            
            Spacer()
        }
    }
    
    var OutlineBlock: some View {
        HStack(spacing: 0) {
            Block(width: 5, height: 5)
            
            if linked {
                ButtonCustom(width: 33, height: 13, color: usertask.type.color.opacity(linkHover ? 0.5 : 1), radius: 2) {
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
                        .kerning(1)
                        .offset(x: 1)
                }
                .padding(.trailing, 5)
                .onHover { value in
                    linkHover = value
                }
            }

            TextField("Link or Description...", text: $outline)
                .foregroundColor(.primary75)
                .font(.system(size: 12, weight: (outline.isEmpty ? .ultraLight : .light), design: .default))
                .frame(height: 12)
                .lineLimit(1)
                .textFieldStyle(.plain)
        }
    }
    
    var ContentPageBlock: some View {
        ButtonCustom(width: 25, height: 25) {
            withAnimation {
                if currentID == usertask.id {
                    container.interactor.usertask.SetCurrentUsertask(nil)
                } else {
                    container.interactor.usertask.SetCurrentUsertask(usertask)
                }
                container.interactor.tasklist.ResetMarkdownFocus()
            }
        } content: {
            Image(systemName: "chevron.right")
                .font(.title2)
                .foregroundColor(usertask.content.isEmpty ? .section : .primary50.opacity(0.75))
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
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            Row(Usertask.preview.urgent1)
            Row(Usertask.preview.archive)
            Row(Usertask.preview.normal)
            Row(Usertask.preview.todo)
            Row(Usertask(0, "", "", "", false, .custom))
        }
        .frame(width: 300)
        .padding()
        .preferredColorScheme(.light)
        .background()
        
        VStack(spacing: 0) {
            Row(Usertask.preview.urgent1)
            Row(Usertask.preview.archive)
            Row(Usertask.preview.normal)
            Row(Usertask.preview.todo)
            Row(Usertask(0, "", "", "", false, .custom))
        }
        .frame(width: 300)
        .padding()
        .preferredColorScheme(.dark)
        .background()
    }
    
    @MainActor
    static func Row(_ task: Usertask) -> some View {
        TaskRow(usertask: .constant(task), currentID: .constant(UUID()), searched: .constant(true))
        .environment(\.locale, .US)
        .inject(DIContainer.preview)
    }
}
