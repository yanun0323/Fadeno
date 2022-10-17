import SwiftUI
import UIComponent

struct MainView: View {
    @EnvironmentObject private var container: DIContainer
    @State private var router: Int = 1
    private let sidebarWidth: CGFloat = 40
    
    var body: some View {
        HStack(spacing: 0) {
            SidebarBlock
            Separator(direction: .vertical, color: .section, size: 1)
            switch router {
            case 1:
                TaskListView()
            default:
                Rectangle()
                    .foregroundColor(.transparent)
                    .overlay {
                        Text("Home")
                    }
            }
        }
    }
}

// MARK: View Block
extension MainView {
    var SidebarBlock: some View {
        VStack(spacing: 10) {
            ButtonCustom(width: sidebarWidth, height: sidebarWidth) {
                withAnimation {
                    router = 0
                }
            } content: {
                HStack(spacing: 0) {
                    Block(width: 5, height: sidebarWidth, color: router == 0 ? .blue : .transparent)
                    Image(systemName: "house.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .frame(width: sidebarWidth-10)
                    Block(width: 5, height: sidebarWidth)
                }
            }
            ButtonCustom(width: sidebarWidth, height: sidebarWidth) {
                withAnimation {
                    router = 1
                }
            } content: {
                HStack(spacing: 0) {
                    Block(width: 5, height: sidebarWidth, color: router == 1 ? .blue : .transparent)
                    Image(systemName: "checklist")
                        .font(.title)
                        .foregroundColor(.gray)
                        .frame(width: sidebarWidth-10)
                    Block(width: 5, height: sidebarWidth)
                }
            }

            Spacer()
        }
        .background(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .inject(DIContainer.preview)
    }
}
