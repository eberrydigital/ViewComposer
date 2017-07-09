//
//  ExpressibleByAttributes+Mergable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public extension Attributed {
    func merge(overwrittenBy dominant: Self) -> Self {
        return AttributesMerger.merge(dominant: dominant, yielding: self)
    }
    
    func merge(overwrittenBy dominant: [Attribute]) -> Self {
        return merge(overwrittenBy: Self(dominant))
    }
    
    func merge(overwrittenBy dominant: Attribute) -> Self {
        return merge(overwrittenBy: [dominant])
    }
}

//MARK: - Yielding
public extension Attributed {
    
    func merge(superiorTo yielding: Self) -> Self {
        return yielding.merge(overwrittenBy: self)
    }
    
    func merge(superiorTo yielding: [Attribute]) -> Self {
        return merge(superiorTo: Self(yielding))
    }
    
    func merge(superiorTo yielding: Attribute) -> Self {
        return merge(superiorTo: [yielding])
    }
}
