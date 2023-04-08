//
//  ARViewScreen.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-04-07.
//

import SwiftUI
import RealityKit

struct ARViewScreen: View {
    var controller: ARController
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
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                )
            }
            
        }
        
    }
}

struct ARViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ARViewScreen(controller: ARController())
    }
}
