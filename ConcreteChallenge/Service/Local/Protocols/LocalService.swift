//
//  LocalService.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 06/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol LocalService: AnyObject {
    func save<T: Codable>(_ object: T, fileName: String)
    func get<T: Codable>(fileName: String) -> T?
}
