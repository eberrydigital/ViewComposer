//
//  ViewAttribute+Mergeable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-06-10.
//
//

import Foundation

extension ViewAttribute {
    func merge(overwrittenBy dominant: ViewStyle) -> ViewStyle {
        return self <<- dominant
    }
    
    func merge(overwrittenBy dominant: [ViewAttribute]) -> ViewStyle {
        return self <<- dominant
    }
    
    func merge(overwrittenBy dominant: ViewAttribute) -> ViewStyle {
        return self <<- dominant
    }
    
    func merge(superiorTo yielding: ViewStyle) -> ViewStyle {
        return self <- yielding
    }
    
    func merge(superiorTo yielding: [ViewAttribute]) -> ViewStyle {
        return self <- yielding
    }
    
    func merge(superiorTo yielding: ViewAttribute) -> ViewStyle {
        return self <- yielding
    }
}

