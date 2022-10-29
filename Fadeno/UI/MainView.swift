import SwiftUI
import UIComponent

struct MainView: View {
    @EnvironmentObject private var container: DIContainer
    @State private var router: Int = 0
    @State private var popupProfile: Bool = false
    @State private var deleting: Bool = false
    @State private var taskToDelete: Usertask? = nil
    private let sidebarWidth: CGFloat = 40
    private let sidebarPadding: CGFloat = 5
    private let iconFont: Font = .system(size: 20, weight: .light, design: .default)
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                SidebarBlock
                Separator(direction: .vertical, color: .section, size: 1)
                switch router {
                    case 1:
                        MultipleTaskListView()
                    case 2:
                        SingleTaskListView(type: .archived)
                    case 3:
                        SingleTaskListView(type: .complete)
                    case 98:
                        ProfileView()
                    case 99:
                        SettingView()
                    case 100:
                        HomeView()
                    default:
                        MultipleTaskListView()
                }
            }
            .blur(radius: deleting ? 10 : 0)
            .disabled(deleting && taskToDelete != nil)
            
            VStack(spacing: 0) {
                if deleting && taskToDelete != nil {
                    DeleteBlock(taskToDelete: taskToDelete!, deleting: $deleting)
                }
            }
        }
        .onReceive(container.appstate.userdata.deleteTask) { value in
            taskToDelete = value
            deleting = true
        }
        .onChange(of: deleting) { value in
            if value == false {
                taskToDelete = nil
            }
        }
    }
}

// MARK: View Block
extension MainView {
    var SidebarBlock: some View {
        VStack(spacing: 5) {
            SidebarButton(image: "house", selected: "house.fill", page: 0)
            SidebarButton(image: "archivebox", selected: "archivebox.fill", page: 2)
            SidebarButton(image: "checkmark", page: 3)
            
            Spacer()
            
            SidebarButton(image: "person.circle", page: 98)
            .popover(isPresented: $popupProfile, arrowEdge: .trailing, content: ProfileViewBlock)
            SidebarButton(image: "gearshape", selected: "gearshape.fill", page: 99)
        }
    }
}

// MARK: Function
extension MainView {
    func ProfileViewBlock() -> some View {
        Rectangle()
            .foregroundColor(.transparent)
            .frame(width: 500, height: 200)
            .overlay {
                Text("Profile View")
            }
    }
    
    func SidebarButton(image: String, page: Int = -1) -> some View {
        SidebarButton(image: image, selected: image, page: page)
    }
    
    func SidebarButton(image: String, selected: String, page: Int = -1) -> some View {
        ButtonCustom(width: sidebarWidth - 2*sidebarPadding, height: sidebarWidth - 2*sidebarPadding) {
            withAnimation {
                if page >= 0 && router != page {
                    router = page
                    container.interactor.usertask.SetCurrentUsertask(nil)
                }
            }
        } content: {
            Image(systemName: router == page ? selected : image)
                .font(iconFont)
                .foregroundColor(router == page ? .primary : .primary50)
        }
        .padding(sidebarPadding/2)
        .background(router == page ? Color.section : Color.transparent)
        .cornerRadius(10)
        .padding(sidebarPadding/2)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .inject(DIContainer.preview)
    }
}
