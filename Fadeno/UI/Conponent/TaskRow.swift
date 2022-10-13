import Foundation
import SwiftUI
import UIComponent

@MainActor
struct TaskRow: View {
    @EnvironmentObject private var container: DIContainer
    @Environment(\.openURL) private var openURL
    @State var userTask: UserTask
    @State var title: String
    @State var outline: String
    @State var content: String
    @State var isPopover: Bool = false
    
    /* cache */
    @State private var detail = false
    @State private var linked = false
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .foregroundColor(userTask.type.color)
                .frame(width: 5)
                .padding(.vertical, 1)
                .opacity(userTask.complete ? 0.2 : 1)
            
            VStack(alignment: .leading, spacing: 0) {
                TitleRowBlock
                NoteRowBlock
            }
            Block(width: 5)
            CompleteBlock
            if isPopover {
                PopoverTrigerBlock
            } else {
                ContentPageBlock
            }
        }
        .frame(height: isPopover ? 30 : 50)
        .lineLimit(1)
        .truncationMode(.tail)
        .background(.background)
        .onAppear {
            linked = IsLink(outline)
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
                    if userTask.title != value {
                        title = value
                        userTask.title = value
                        #if DEBUG
                        print("Changed!")
                        #endif
                    }
                }))
                .font(.system(size: 14, weight: .light, design: .default))
                .lineLimit(1)
                .textFieldStyle(.plain)
                .disabled(userTask.complete)
            
            Spacer()
        }
    }
    
    var NoteRowBlock: some View {
        HStack(spacing: 0) {
            Block(width: 5)
            
            if linked {
                ButtonCustom(width: 30, height: 11, color: .primary25, radius: 1) {
                    let str = userTask.outline.split(separator: " ").first(where: { $0.contains("https://") })
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
                    if userTask.outline != value {
                        outline = value
                        userTask.outline = value
                        linked = IsLink(value)
                        #if DEBUG
                        print("Changed!")
                        #endif
                    }
                }))
                .foregroundColor(.primary75)
                .font(.system(size: 10, weight: .thin, design: .default))
                .frame(height: 10)
                .lineLimit(1)
                .textFieldStyle(.plain)
                .disabled(userTask.complete)
        }
    }
    
    var CompleteBlock: some View {
        ButtonCustom(width: 25, height: 25, radius: 5) {
            withAnimation {
                userTask.complete.toggle()
            }
        } content: {
            Image(systemName: userTask.complete ? "checkmark.circle.fill" : "circle")
                .font(.title3)
                .foregroundColor(.primary50.opacity( userTask.complete ? 0.3 : 0.75))
        }
    }
    
    var PopoverTrigerBlock: some View {
        ButtonCustom(width: 25, height: 25, radius: 5) {
            if container.appState.userSetting.popoverClick {
                detail = true
            }
        } content: {
            Image(systemName: content.isEmpty ?  "bubble.middle.bottom" : "bubble.middle.bottom.fill")
                .foregroundColor(.primary50.opacity( userTask.complete ? 0.3 : 0.75))
        }
        .onHover(perform: { value in
            if container.appState.shared.page == -1 {
                detail = false
                return
            }
            
            if container.appState.userSetting.popoverClick {
                detail = detail
                return
            }
            
            if container.appState.userSetting.popoverAutoClose {
                detail = value
                return
            }
            detail = true
            
        })
        .popover(isPresented: $detail, arrowEdge: .trailing) {
            ZStack {
                TextEditor(text: userTask.complete ? .constant(content) : Binding(
                    get: {
                        content
                    }, set: { value in
                        content = value
                        if userTask.content != value {
                            userTask.content = value
                            #if DEBUG
                            print("Changed!")
                            #endif
                        }
                    }))
                    .font(.system(size: 14, weight: .thin, design: .default))
                    .background(.clear)
                    .frame(width: CGFloat(container.appState.userSetting.popoverWidth),
                           height: CGFloat((content.filter { $0 == "\n" }.count+1) * (14+3)),
                           alignment: .leading)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
    }
    
    var ContentPageBlock: some View {
        ButtonCustom(width: 40, height: 40) {
            withAnimation {
                container.appState.shared.currentTask = userTask
                print("current user task: \(container.appState.shared.currentTask.title)")
            }
        } content: {
            Image(systemName: "chevron.right")
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
            Row(UserTask.preview.urgent)
            Row(UserTask.preview.archive)
            Row(UserTask.preview.normal)
            Row(UserTask.preview.todo)
        }
        .frame(width: 300)
        .padding()
        .preferredColorScheme(.light)
        .background(.background)
        
        VStack {
            Row(UserTask.preview.urgent)
            Row(UserTask.preview.archive)
            Row(UserTask.preview.normal)
            Row(UserTask.preview.todo)
        }
        .frame(width: 300)
        .padding()
        .preferredColorScheme(.dark)
        .background(.background)
    }
    
    @MainActor
    static func Row(_ task: UserTask) -> some View {
        TaskRow(
            userTask: task,
            title: "",
            outline: "",
            content: ""
        )
        .environment(\.locale, .US)
        .inject(DIContainer.preview)
    }
}
