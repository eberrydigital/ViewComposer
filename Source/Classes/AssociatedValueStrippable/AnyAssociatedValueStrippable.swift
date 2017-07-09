//
//  AnyAssociatedValueStrippable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public struct AnyAttribute: AttributeType {
    
    private let _getAssociatedValue: () -> Any?
    private let _getStripped: () -> AnyStrippedRepresentation
    
    public var associatedValue: Any? { return _getAssociatedValue() }
    public var stripped: AnyStrippedRepresentation { return _getStripped() }
    
    public init<Base: AttributeType>(_ base: Base) {
        _getAssociatedValue = { base.associatedValue }
        _getStripped = { AnyStrippedRepresentation(base.stripped) }
    }
}
