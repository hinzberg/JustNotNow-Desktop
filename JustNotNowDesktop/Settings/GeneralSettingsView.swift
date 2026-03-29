import SwiftUI
import AppKit

struct GeneralSettingsView: View {
    @AppStorage("DataFolder") private var dataFolder: String = ""
    
    var body: some View {
        HStack {
            TextField("Select data folder", text: $dataFolder)
            
            Button("Choose...") {
                chooseFolder()
            }
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
