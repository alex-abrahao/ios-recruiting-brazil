//
//  TesterExtension.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 20/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import XCTest
import KIF

extension XCTestCase {
    
    var tester: KIFUITestActor { return tester() }
    var system: KIFSystemTestActor { return system() }
    
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    
    var tester: KIFUITestActor { return tester() }
    var system: KIFSystemTestActor { return system() }
    
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
