//
//  BroweModelsScreen.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-04-11.
//

import SwiftUI

struct BrowseModelsScreen: View {
    @ObservedObject var controller: ModelController
    @State private var isImporting = false
    var body: some View {
        VStack{
            List{
                if(!controller.modelList.isEmpty){
                    Section(header: Text("Imported Files")){
                        ForEach(controller.modelList, id: \.self){
                            file in
                            
                            NavigationLink(file.deletingPathExtension().lastPathComponent, destination: ARViewScreen(model: file))
                        }
                    }
                }
                Section(header: Text("Import Options")){
                    Button("Local File"){
                        isImporting = true
                    }
                    .buttonStyle(.automatic)
                }
                
            }
            
        }
        .navigationTitle("Browse Models")
        .task {
            controller.fetchConvertedFiles()
        }
        .fileImporter(
                    isPresented: $isImporting,
                    allowedContentTypes: [.item],
                    allowsMultipleSelection: false
                ) { result in
                    do {
                        guard let selectedFile: URL = try result.get().first else { return }
                        if selectedFile.startAccessingSecurityScopedResource() {
                            defer { selectedFile.stopAccessingSecurityScopedResource() }
                            
                            print("Trying to convert Selected File")
                            let convertedURL = try convertToUSDz(urlpath: selectedFile)
                            print(convertedURL)
                            controller.modelList.append(convertedURL)
                            
                        } else {
                            // Handle denied access
                            print("Access denied")
                        }
                    } catch {
                        // Handle failure.
                        print("Unable to read file contents")
                        print(error.localizedDescription)
                    }
                }
    }
}

struct BrowseModelsScreen_Previews: PreviewProvider {
    static var previews: some View {
        BrowseModelsScreen(controller: ModelController())
    }
}
