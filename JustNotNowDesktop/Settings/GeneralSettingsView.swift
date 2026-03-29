import SwiftUI
import AppKit

struct GeneralSettingsView: View {
    @AppStorage("DataFolder") private var dataFolder: String = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Folder Location to Store Data")
                .font(.title2)
            HStack {
                TextField("Select data folder", text: $dataFolder)
                    .font(.title2)
                
                Button(role: .confirm) {
                    chooseFolder()
                } label: {
                    Text("Choose...")
                        .font(.title2)
                        .frame(width: 70)
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer()
        }
    }
    
    private func chooseFolder() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        
        if panel.runModal() == .OK, let url = panel.url {
            dataFolder = url.path
        }
    }
}

#Preview {
    GeneralSettingsView()
}
