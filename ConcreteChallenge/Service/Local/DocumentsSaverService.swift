//
//  DocumentsSaverService.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 19/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
import os.log

class DocumentsSaverService {
    
    /// System default Documents Directory
    private let documentsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    /// Get a URL to a file in documentsDir
    private func getURLInDocumentDir(for file: String) -> URL {
        return URL(fileURLWithPath: documentsDir.appendingPathComponent(file + ".json"))
    }
    
    /// Save any object as a JSON of a dictionary
    func save<T: Codable>(_ object: [Int : T], fileName: String) {
        
        let url = getURLInDocumentDir(for: fileName)
        
        do {
            try JSONEncoder().encode(object).write(to: url)
            os_log("💾 - Saved objects at %@", log: Logger.appLog(), type: .info, String(describing: url))
        } catch {
            os_log("❌ - Could not save at %@", log: Logger.appLog(), type: .fault, String(describing: url))
        }
    }
    
    /// Get the objects dictionary for any `Codable` type
    func get<T: Codable>(fileName: String) -> [Int : T]? {
        let url = getURLInDocumentDir(for: fileName)
        do {
            let readData = try Data(contentsOf: url)
            let dictionary = try JSONDecoder().decode([Int : T].self, from: readData)
            return dictionary
        } catch {
            os_log("Could not read from %@", log: Logger.appLog(), type: .info, String(describing: url))
        }
        return nil
    }
}
