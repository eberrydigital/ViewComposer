//
//  AnyAssociatedValueStrippable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

//swiftlint:disable generic_type_name
public final class AnyAssociatedValueStrippable<_Stripped: StrippedRepresentation>: AttributeType {
    
    public typealias Stripped = _Stripped
    private let box: _AnyAssociatedValueStrippableBase<Stripped>
    
    public init<Concrete: AttributeType>(_ concrete: Concrete) where Concrete.Stripped == Stripped {
        box = _AnyAssociatedValueStrippableBox(concrete)
    }
    
    public var associatedValue: Any? { return box.stripped }
    public var stripped: Stripped { return box.stripped }
    
}

private final class _AnyAssociatedValueStrippableBox<Concrete: AttributeType>: _AnyAssociatedValueStrippableBase<Concrete.Stripped> {
    private var concrete: Concrete
    
    init(_ concrete: Concrete) {
        self.concrete = concrete
    }
    
    override var associatedValue: Any? { return concrete.associatedValue }
    override var stripped: Stripped { return concrete.stripped }
}

private class _AnyAssociatedValueStrippableBase<_Stripped: StrippedRepresentation>: AttributeType {
    typealias Stripped = _Stripped
    init() {
        guard type(of: self) != _AnyAssociatedValueStrippableBase.self else { fatalError("Use Box class") }
    }
    
    var associatedValue: Any? { fatalError() }
    var stripped: Stripped { fatalError() }
}
