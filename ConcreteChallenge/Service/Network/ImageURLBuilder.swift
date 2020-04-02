//
//  ImageURLBuilder.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 02/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

struct ImageURLBuilder {
    
    enum ImageType {
        case poster
        case backdrop
    }
    
    static func url(for imageType: ImageType, path: String?) -> URL? {
        guard let path = path else { return nil }
        
        var url = URL(string: NetworkInfo.ProductionServer.imageBaseURL)
        
        switch imageType {
        case .poster:
            url?.appendPathComponent("w500")
        default:
            url?.appendPathComponent("w780")
        }
        
        url?.appendPathComponent(path)
        return url
    }
}
