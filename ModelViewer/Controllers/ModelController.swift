//
//  ModelController.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-04-11.
//

import Foundation

class ModelController: ObservableObject {
    
    @Published var modelList = [URL]()
    
    func fetchConvertedFiles(){
        var contents: [URL]
        
        do{
            contents = try FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil)
        }catch{
            print("Fetch Error: \(error)")
            return
        }
        
        print("Contents: \(contents)")
        modelList = contents
    }
}
