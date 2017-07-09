//
//  ExpressibleByAttributes+Array+Mergeable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public extension Array where Element: AssociatedValueStrippable {
    
    func merge<A: Attributed>(superiorTo yielding: A) -> A where A.Attribute == Element {
        return A(self).merge(superiorTo: yielding)
    }
    
    func merge<A: Attributed>(overwrittenBy dominant: A) -> A where A.Attribute == Element {
        return A(self).merge(overwrittenBy: dominant)
    }
}
