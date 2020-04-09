//
//  Movie+Equatable.swift
//  ConcreteChallengeTests
//
//  Created by alexandre.c.ferreira on 09/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

@testable import Movs

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
}
