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
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
    
        let urlpath = Bundle.main.url(forResource: "bulb", withExtension: "STL")
        
        let convertedURL: URL
        
        do{
            convertedURL = try convertToUSDz(urlpath: urlpath!)
        }
        catch {
            print(error)
            return arView
        }
        
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        //let object = model.object(at: 0)
        
        do{ //Load 3D model associated with the detected part
            let customEntity = try ModelEntity.loadModel(contentsOf: convertedURL)
            print(customEntity)
            boxAnchor.addChild(customEntity)
            //Should be 0.1 scale
            customEntity.setScale(SIMD3(x: 0.5, y: 0.5, z: 0.5), relativeTo: customEntity)
            
            //Change color
            var material = SimpleMaterial()
            material.color = .init(tint: .green)
            material.roughness = 0.2
            material.metallic = 0.7
            
            //customEntity.model?.materials[0] = material
            customEntity.model?.materials.append(material)
            
            print(customEntity.model ?? "No model")
        }
        catch {
            print("Failed to load custom model")
            print(error)
        }
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}


