//
//  BroweModelsScreen.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-04-11.
//

import SwiftUI

struct BrowseModelsScreen: View {
    @ObservedObject var controller: ModelController
    var body: some View {
        VStack{
            Text("Imported Models")
            Button("Fetch Models"){
                controller.fetchConvertedFiles()
            }
            List{
                ForEach(controller.modelList, id: \.self){
                    file in
                    
                    NavigationLink(file.deletingPathExtension().lastPathComponent, destination: ARViewScreen(model: file))
                }
            }
            
        }
        .navigationTitle("Browse Models")
    }
}

struct BrowseModelsScreen_Previews: PreviewProvider {
    static var previews: some View {
        BrowseModelsScreen(controller: ModelController())
    }
}
