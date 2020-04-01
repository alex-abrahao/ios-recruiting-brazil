//
//  NetworkError.swift
//  ConcreteChallenge
//
//  Created by alexandre.c.ferreira on 31/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

enum NetworkError: String, Error {
    case nilParameters = "Parameters were nil."
    case parameterEncodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
    case missingData = "Data is nil"
}
