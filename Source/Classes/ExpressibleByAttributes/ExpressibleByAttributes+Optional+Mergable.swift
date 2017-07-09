//
//  ExpressibleByAttributes+Optional+Mergable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public extension Optional where Wrapped: Attributed {
    func merge(overwrittenBy dominant: Wrapped) -> Wrapped {
        guard let `self` = self else { return dominant }
        return self.merge(overwrittenBy: dominant)
    }
    
    func merge(superiorTo yielding: Wrapped) -> Wrapped {
        guard let `self` = self else { return yielding }
        return self.merge(superiorTo: yielding)
    }
}
