//
//  AnyExpressibleByAttributes.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

//swiftlint:disable generic_type_name
public final class AnyExpressibleByAttributes<_Attribute: AttributeType>: ExpressibleByAttributes {
    public typealias Attribute = _Attribute
    private let box: _AnyExpressibleByAttributesBase<Attribute>
    
    public init<Concrete: ExpressibleByAttributes>(_ concrete: Concrete) where Concrete.Attribute == Attribute {
        box = _AnyExpressibleByAttributesBox(concrete)
    }
    
    public func install(on styleable: Any) { box.install(on: styleable) }
    public var attributes: [Attribute] {
        set { box.attributes = newValue }
        get { return box.attributes }
    }
}

private final class _AnyExpressibleByAttributesBox<Concrete: ExpressibleByAttributes>: _AnyExpressibleByAttributesBase<Concrete.Attribute> {
    private var concrete: Concrete
    
    init(_ concrete: Concrete) {
        self.concrete = concrete
    }
    
    override func install(on styleable: Any) { concrete.install(on: styleable) }
    override var attributes: [Attribute] {
        set { concrete.attributes = newValue }
        get { return concrete.attributes }
    }
}

private class _AnyExpressibleByAttributesBase<_Attribute: AttributeType>: ExpressibleByAttributes {
    typealias Attribute = _Attribute
    init() {
        guard type(of: self) != _AnyExpressibleByAttributesBase.self else { fatalError("Use Box class") }
    }
    func install(on styleable: Any) { abstractMethod() }
    var attributes: [Attribute] {
        set { abstractMethod() }
        get { abstractMethod() }
    }
}
