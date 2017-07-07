//
//  ViewAttribute+Mergeable+Array.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-06-10.
//
//

import Foundation

public extension Array where Element == ViewAttribute {
    func merge(overwrittenBy dominant: [ViewAttribute]) -> ViewStyle {
        return ViewStyle(self).merge(overwrittenBy: dominant)
    }
    
    func merge(overwrittenBy dominant: ViewAttribute) -> ViewStyle {
        return merge(overwrittenBy: [dominant])
    }
    
    func merge(superiorTo yielding: [ViewAttribute]) -> ViewStyle {
        return ViewStyle(self).merge(superiorTo: yielding)
    }
    
    func merge(superiorTo yielding: ViewAttribute) -> ViewStyle {
        return merge(superiorTo: [yielding])
    }
    
}
