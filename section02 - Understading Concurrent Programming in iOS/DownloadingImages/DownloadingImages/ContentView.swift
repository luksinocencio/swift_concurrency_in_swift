import SwiftUI

struct ContentView: View {
    private func downloadImage() {
        guard let imageURL = URL(string: "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=1352&auto=format&fit=crop&uuid=\(UUID().uuidString)") else {
            return
        }
        
        print(imageURL)
        
        DispatchQueue.global().async {
            let _ = try? Data(contentsOf:  imageURL)
            
            DispatchQueue.main.async {
                // update the ui
            }
        }
        
        
    }
    
    var body: some View {
        VStack {
            List(1...20, id: \.self) { index in
                Text("\(index)")
            }
            
            Button {
                downloadImage()
            } label: {
                Label("Download Image", systemImage: "arrow.down")
            }.tint(.teal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
