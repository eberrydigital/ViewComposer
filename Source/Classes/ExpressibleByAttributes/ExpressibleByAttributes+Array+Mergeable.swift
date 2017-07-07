//
//  ExpressibleByAttributes+Array+Mergeable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public extension Array where Element: AssociatedValueStrippable {
    
    func merge<E: ExpressibleByAttributes>(superiorTo yielding: E) -> E where E.Attribute == Element {
        return E(self).merge(superiorTo: yielding)
    }
    
    func merge<E: ExpressibleByAttributes>(overwrittenBy dominant: E) -> E where E.Attribute == Element {
        return E(self).merge(overwrittenBy: dominant)
    }
}
