//
//  ModelInteractButton.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-04-08.
//

import SwiftUI

struct ModelInteractButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .padding()
            .foregroundColor(configuration.isPressed ? .gray : .black)
            .background(.gray.opacity(0.4))
            .cornerRadius(15)
            .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
}

struct ModelInteractToggle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .padding(8)
            .foregroundColor(.black)
            .background(configuration.isOn ? .green.opacity(0.4) : .gray.opacity(0.4))
            .cornerRadius(15)
            .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 2)
                )
            .onTapGesture {
                configuration.isOn.toggle()
            }
        }
}

struct ModelIntrectTestView: View {
    
    @State var toggle = false
    
    var body: some View {
        VStack{
            Button("X+"){
                
            }
            .buttonStyle(ModelInteractButton())
            Toggle("Lock\nROT", isOn: $toggle)
            .toggleStyle(ModelInteractToggle())
        }
    }
}

struct ModelInteractButton_Previews: PreviewProvider {
    static var previews: some View {
        ModelIntrectTestView()
    }
}
