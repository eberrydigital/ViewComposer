//
//  ExpressibleByAttributes+CustomStringConvertible.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public extension ExpressibleByAttributes {
    var description: String {
        var attributesAsString = [String]()
        for attribute in attributes {
            guard let value = attribute.associatedValue else { continue }
            attributesAsString.append("\(attribute.stripped.rawValue): \(value)")
        }
        return "[\(attributesAsString.joined(separator: ", "))]"
    }
}
