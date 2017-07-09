//
//  AnyExpressibleByAttributes.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public struct AnyExpressibleByAttributes: ExpressibleByAttributes {
        
    public init<Base: ExpressibleByAttributes>(_ base: Base) {
        _install = base.install(on:)
        _getAttributes = { base.attributes.map { AnyAttribute($0) } }
    }
    
    private let _install: (Any) -> Void
    private let _getAttributes: () -> [AnyAttribute]
    
    public func install(on styleable: Any) { _install(styleable) }
    public var attributes: [AnyAttribute] { return _getAttributes() }
}
