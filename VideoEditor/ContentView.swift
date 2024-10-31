import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                    .padding()

                // Gebruik hier VideoEditorView in plaats van VideoEditorApp
                NavigationLink(destination: VideoEditorView()) {
                    Text("Open Video Editor")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
