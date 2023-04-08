//
//  ARViewScreen.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-04-07.
//

import SwiftUI

struct ARViewScreen: View {
    var controller: ARController
    var body: some View {
        ARViewContainer(controller: controller).edgesIgnoringSafeArea(.all)
            .onTapGesture(coordinateSpace: .global) { location in
                            controller.raycastFunc(location: location)
                        }
    }
}

struct ARViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ARViewScreen(controller: ARController())
    }
}
