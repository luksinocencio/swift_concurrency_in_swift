import SwiftUI

struct ContentView: View {
    
    private func getData() async {
        
    }
    
    var body: some View {
        VStack {
            Button {
                // Como este botão não é async, usamos Task.init para rodar nossa função
                Task.init { await getData() }
            } label: {
                Text("Get Data")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.teal)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
