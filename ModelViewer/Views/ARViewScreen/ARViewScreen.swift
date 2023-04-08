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
            HStack{
                VStack{
                    Button(action: {
                        controller.rotateModel(amount: simd_quatf(angle: Float.pi/4, axis: [0, 1, 0]))
                    }){
                        Text("Y+")
                            .padding()
                            //.frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(.black)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                    }
                    Button(action: {
                        controller.rotateModel(amount: simd_quatf(angle: -Float.pi/4, axis: [0, 1, 0]))
                    }){
                        Text("Y-")
                            .padding()
                            .foregroundColor(.black)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                    }
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

struct ARViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ARViewScreen(controller: ARController())
    }
}
