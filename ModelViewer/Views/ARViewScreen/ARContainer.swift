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
        //let url = URL(fileURLWithPath: urlpath!)
        let model = MDLAsset(url: urlpath!)
        
        if(MDLAsset.canExportFileExtension("usdc")){
            let writeurl = getDocumentsDirectory().appendingPathComponent("model.usdc")
            
            print("yes")
            
            do{
                print("Trying Conversion")
                
                try model.export(to: writeurl)
                
                print("Finished Conversion")
                
                do {
                    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                    //let documentDirectory = URL(fileURLWithPath: path)
                    let originPath = getDocumentsDirectory().appendingPathComponent("model.usdc")
                    let destinationPath = getDocumentsDirectory().appendingPathComponent("model.usdz")
                    try FileManager.default.moveItem(at: originPath, to: destinationPath)
                    
                    print("Rename Finished")
                } catch {
                    print(error)
                }
                
                
            }
            catch{
                print("Export error \(error)")
            }
            
        }else {
            print("no")
        }
        
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        //let object = model.object(at: 0)
        
        do{ //Load 3D model associated with the detected part
            let customEntity = try ModelEntity.loadModel(contentsOf: getDocumentsDirectory().appendingPathComponent("model.usdc"))
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

func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
}
