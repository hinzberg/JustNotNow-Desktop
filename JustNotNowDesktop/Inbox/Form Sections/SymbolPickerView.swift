import SwiftUI

struct SymbolPickerView: View {
    @Binding var selectedSymbol: String
    @Environment(\.dismiss) private var dismiss
    @State private var tappedSymbol: String?
    
    let symbols = [
        "star", "heart", "bolt", "flame", "moon", "sun.max",
        "cloud", "umbrella", "leaf", "pawprint", "hare", "tortoise",
        "bicycle", "car", "airplane", "tram", "figure.walk", "figure.run",
        "cart", "creditcard", "bag", "gift", "bell", "bookmark",
        "music.note", "headphones", "tv", "laptopcomputer", "gamecontroller", "camera",
        "house", "building", "bed.double", "globe", "flag", "paperplane"
    ]
    
    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Divider()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(symbols, id: \.self) { symbol in
                            Image(systemName: symbol)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .padding(8)
                                .background(selectedSymbol == symbol ? Colors.primaryAccent : Color.clear)
                                .cornerRadius(8)
                                .scaleEffect(tappedSymbol == symbol ? 1.3 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: tappedSymbol)
                                .onTapGesture {
                                    tappedSymbol = symbol
                                    selectedSymbol = symbol
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        dismiss()
                                    }
                                }
                                .foregroundColor(.primary)
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                Button(role: .close) {
                    dismiss()
                }
            }
            .navigationTitle("Select Symbol")
        }
    }
}

