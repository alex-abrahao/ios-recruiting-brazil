//
//  ViewCode.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 06/04/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupView()
    func setupAdditionalConfiguration()
}

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {}
}
