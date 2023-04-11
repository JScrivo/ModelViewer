//
//  ARViewScreen.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-04-07.
//

import SwiftUI
import RealityKit

struct ARViewScreen: View {
    @EnvironmentObject var controller: ARController
    var model: URL
    
    
    var body: some View {
        
        ZStack{
            ARViewContainer(controller: controller).edgesIgnoringSafeArea(.all)
                .onTapGesture(coordinateSpace: .global) { location in
                                controller.raycastFunc(location: location)
                            }
            
            VStack{
                Spacer()
                HStack{
                    VStack{
                        Button("X+"){
                            controller.rotateModel(amount: simd_quatf(angle: Float.pi/4, axis: [1, 0, 0]))
                        }
                        .buttonStyle(ModelInteractButton())
                        Button("X-"){
                            controller.rotateModel(amount: simd_quatf(angle: -Float.pi/4, axis: [1, 0, 0]))
                        }
                        .buttonStyle(ModelInteractButton())
                    }
                    VStack{
                        Button("Y+"){
                            controller.rotateModel(amount: simd_quatf(angle: Float.pi/4, axis: [0, 1, 0]))
                        }
                        .buttonStyle(ModelInteractButton())
                        Button("Y-"){
                            controller.rotateModel(amount: simd_quatf(angle: -Float.pi/4, axis: [0, 1, 0]))
                        }
                        .buttonStyle(ModelInteractButton())
                    }
                    VStack{
                        Button("Z+"){
                            controller.rotateModel(amount: simd_quatf(angle: Float.pi/4, axis: [0, 0, 1]))
                        }
                        .buttonStyle(ModelInteractButton())
                        Button("Z-"){
                            controller.rotateModel(amount: simd_quatf(angle: -Float.pi/4, axis: [0, 0, 1]))
                        }
                        .buttonStyle(ModelInteractButton())
                    }
                    VStack{
                        Toggle("Lock\nROT", isOn: $controller.lockRot)
                        .toggleStyle(ModelInteractToggle())
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                )
            }
            
        }.task {
            controller.loadModel(convertedURL: model)
        }
        
    }
}

struct ARViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ARViewScreen(model: URL(fileURLWithPath: ""))
    }
}
