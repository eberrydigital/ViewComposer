//
//  Makeable+Mergeable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-06-09.
//
//

import Foundation

public extension Attributed {
    
    func merge<M: Makeable>(superiorTo yielding: Self) -> M where M.Styled == M, M.Style == Self {
        return M.make(merge(superiorTo: yielding))
    }
    
    func merge<M: Makeable>(overwrittenBy dominant: Self) -> M where M.Styled == M, M.Style == Self {
        return dominant.merge(superiorTo: self)
    }
    
    func merge<M: Makeable>(superiorTo yielding: Attribute) -> M where M.Styled == M, M.Style == Self {
        return merge(superiorTo: Self([yielding]))
    }
    
    func merge<M: Makeable>(overwrittenBy dominant: Attribute) -> M where M.Styled == M, M.Style == Self {
        return merge(overwrittenBy: Self([dominant]))
    }
}
