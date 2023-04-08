//
//  ARController.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-04-07.
//

import Foundation
import RealityKit

class ARController: ObservableObject {
    
    @Published var model: ModelEntity?
    @Published var arView: ARView = ARView(frame: .zero)
    
    init(){
        let urlpath = Bundle.main.url(forResource: "bulb", withExtension: "STL")
        
        initializeModel(url: urlpath!)
    }
    
    func loadModel(convertedURL: URL){
        do{ //Load 3D model associated with the detected part
            let customEntity = try ModelEntity.loadModel(contentsOf: convertedURL)
            print(customEntity)
            //Should be 0.1 scale
            customEntity.setScale(SIMD3(x: 0.1, y: 0.1, z: 0.1), relativeTo: customEntity)
            
            //Change color
            var material = SimpleMaterial()
            material.color = .init(tint: .green)
            material.roughness = 0.2
            material.metallic = 0.7
            
            //customEntity.model?.materials[0] = material
            customEntity.model?.materials.append(material)
            
            print(customEntity.model ?? "No model")
            
            model = customEntity
            
            // Add the box anchor to the scene
            //arView.scene.anchors.append(boxAnchor)
        }
        catch {
            print("Failed to load custom model")
            print(error)
        }
    }
    
    func initializeModel(url: URL){
        let convertedURL: URL
        
        do{
            convertedURL = try convertToUSDz(urlpath: url)
        }
        catch {
            print(error)
            return
        }
        
        loadModel(convertedURL: convertedURL)
    }
    
    func raycastFunc(location: CGPoint) {
        guard let query = arView.makeRaycastQuery(from: location, allowing: .estimatedPlane, alignment: .any)
        else { return }
        
        guard let result = arView.session.raycast(query).first
                
        else { return }
        
        guard let entity = model else {
            return
        }
        
        let raycastAnchor = AnchorEntity(world: result.worldTransform)
        
        raycastAnchor.addChild(entity)
        arView.scene.anchors.append(raycastAnchor)
    }
    
    func rotateModel(amount: simd_quatf){
        guard let entity = model else {
            return
        }
        
        entity.setOrientation(amount, relativeTo: entity)
    }
}
