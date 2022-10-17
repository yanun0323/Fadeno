import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .inject(DIContainer.preview)
    }
}
