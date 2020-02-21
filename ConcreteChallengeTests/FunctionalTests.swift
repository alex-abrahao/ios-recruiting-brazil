//
//  FunctionalTests.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 20/02/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import KIF
import Quick

class FunctionalTest: QuickSpec {
    
    override func spec() {
        
        
        
        beforeEach {
            
        }
        
        describe("movie") {
            
            context("cells") {
                it("should enter a detail view when tapped") {
                    tester()
                }
            }
        }
        
    }
}
