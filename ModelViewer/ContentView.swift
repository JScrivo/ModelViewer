//
//  ContentView.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-03-28.
//

import SwiftUI
import RealityKit
import ModelIO

struct ContentView : View {
    @ObservedObject var arController = ARController()
    var body: some View {
        ARViewScreen(controller: arController)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
