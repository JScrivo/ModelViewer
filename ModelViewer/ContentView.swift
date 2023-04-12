//
//  ContentView.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-03-28.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @StateObject var arController = ARController()
    @ObservedObject var modelController = ModelController()
    var body: some View {
        //ARViewScreen(controller: arController)
        NavigationStack{
            BrowseModelsScreen(controller: modelController)
        }
        .environmentObject(arController)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
