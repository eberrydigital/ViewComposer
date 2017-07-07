//
//  ExpressibleByAttributes+AssociatedValueEnumExtractor.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public extension ExpressibleByAttributes {
    func value<AssociatedValue>(_ stripped: Attribute.Stripped) -> AssociatedValue? {
        return attributes.associatedValue(stripped)
    }
    
    func contains(_ attribute: Attribute.Stripped) -> Bool {
        return stripped.contains(attribute)
    }
}
