//
//  NetworkSessionTaskSpy.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 07/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
@testable import Movs

final class NetworkSessionTaskSpy: NetworkSessionTask {
    
    private(set) var didResume: Bool = false
    private(set) var didCancel: Bool = false
    
    func resume() {
        didResume = true
    }
    
    func cancel() {
        didCancel = true
    }
}
