//
//  ARContainer.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-03-28.
//

import SwiftUI
import RealityKit
import ModelIO

struct ARViewContainer: UIViewRepresentable {
    
    var controller: ARController
    
    func makeUIView(context: Context) -> ARView {
        
        return controller.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}


