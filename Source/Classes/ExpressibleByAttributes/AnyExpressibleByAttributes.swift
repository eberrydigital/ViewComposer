//
//  AnyExpressibleByAttributes.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public struct AnyExpressibleByAttributes: ExpressibleByAttributes {
    
    public init(attributes: [AnyAttribute]) {
        _getAttributes = { attributes.map { AnyAttribute($0) } }
    }
    
    public init<Base: ExpressibleByAttributes>(_ base: Base) {
        _getAttributes = { base.attributes.map { AnyAttribute($0) } }
    }
    
    private let _getAttributes: () -> [AnyAttribute]
    public var attributes: [AnyAttribute] { return _getAttributes() }
}
