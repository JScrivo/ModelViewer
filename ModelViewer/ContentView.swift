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
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

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
                    let documentDirectory = URL(fileURLWithPath: path)
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
            boxAnchor.addChild(customEntity)
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

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
