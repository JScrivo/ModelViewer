//
//  Conversion.swift
//  ModelViewer
//
//  Created by Jordan Scrivo on 2023-04-07.
//

import ModelIO
import RealityKit

enum ConversionError: Error {
    case unsupportedExport
    case unsupportedImport
    case conversionError(message: String)
}


func convertToUSDz(urlpath: URL) throws -> URL{
    
    let name = urlpath.deletingPathExtension().lastPathComponent
    let originalExtension = urlpath.pathExtension
    
    print(name)
    print(originalExtension)
    print(urlpath.lastPathComponent)
    
    guard MDLAsset.canImportFileExtension(originalExtension.lowercased()) else {
        throw ConversionError.unsupportedImport
    }
    
    guard MDLAsset.canExportFileExtension("usdc") else {
        throw ConversionError.unsupportedExport
    }
    
    let model = MDLAsset(url: urlpath)
    
    
    
    let writeurl = getDocumentsDirectory().appendingPathComponent("\(name).usdc")
    
    
    do{
        print("Trying Conversion")
        
        try model.export(to: writeurl)
        
        print("Finished Conversion")
        
        //print("Rename Started")
        
        //let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        //let documentDirectory = URL(fileURLWithPath: path)
        //let originPath = writeurl//getDocumentsDirectory().appendingPathComponent("model.usdc")
        //let destinationPath = getDocumentsDirectory().appendingPathComponent("\(name).usdz")
        //try FileManager.default.moveItem(at: originPath, to: destinationPath)
        
        //print("Rename Finished")
        
        return writeurl

    }
    catch{
        throw ConversionError.conversionError(message: "\(error)")
    }
}

func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
}
