//
//  ModelMock.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 08/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

struct ModelMock: Codable, Equatable {
    var name: String
    var id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    func getJsonData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}
