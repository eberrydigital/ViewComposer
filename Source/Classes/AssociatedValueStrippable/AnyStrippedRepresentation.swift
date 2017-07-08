//
//  AnyStrippedRepresentation.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-08.
//

import Foundation

//swiftlint:disable generic_type_name
public final class AnyStrippedRepresentation<_RawValue>: StrippedRepresentation {
    
    public init?(rawValue: RawValue) {
        print("rawValue: \(rawValue), what to do?")
    }
    
    public static func == (lhs: AnyStrippedRepresentation<RawValue>, rhs: AnyStrippedRepresentation<RawValue>) -> Bool {
        guard let lhsValue = lhs.rawValue as? String, let rhsValue = rhs.rawValue as? String else { fatalError("Only String supported") }
        return lhsValue == rhsValue
    }
    
    public static func < (lhs: AnyStrippedRepresentation<_RawValue>, rhs: AnyStrippedRepresentation<_RawValue>) -> Bool {
        guard let lhsValue = lhs.rawValue as? String, let rhsValue = rhs.rawValue as? String else { fatalError("Only String supported") }
        return lhsValue < rhsValue
    }
    
    public typealias RawValue = _RawValue
    private var box: _AnyStrippedRepresentationBase<RawValue>!
    
    public init<Concrete: StrippedRepresentation>(_ concrete: Concrete) where Concrete.RawValue == RawValue {
        box = _AnyStrippedRepresentationBox(concrete)
    }
    
    public var rawValue: RawValue { return box.rawValue }
    public var hashValue: Int { return box.hashValue }
}

private final class _AnyStrippedRepresentationBox<Concrete: StrippedRepresentation>: _AnyStrippedRepresentationBase<Concrete.RawValue> {
    private var concrete: Concrete
    
    required init(_ concrete: Concrete) {
        self.concrete = concrete
        super.init()
    }
    
    required init?(rawValue: RawValue) {
        fatalError()
    }
    
//    static func == (lhs: AnyStrippedRepresentation<RawValue>, rhs: AnyStrippedRepresentation<RawValue>) -> Bool {
//        guard let lhsValue = lhs.rawValue as? String, let rhsValue = rhs.rawValue as? String else { fatalError("Only String supported") }
//        return lhsValue == rhsValue
//    }
//
//    public static func < (lhs: AnyStrippedRepresentation<_RawValue>, rhs: AnyStrippedRepresentation<_RawValue>) -> Bool {
//        guard let lhsValue = lhs.rawValue as? String, let rhsValue = rhs.rawValue as? String else { fatalError("Only String supported") }
//        return lhsValue < rhsValue
//    }
    
    override var rawValue: RawValue { return concrete.rawValue }
    override var hashValue: Int { return concrete.hashValue }
}

private class _AnyStrippedRepresentationBase<_RawValue>: StrippedRepresentation {
    typealias RawValue = _RawValue
    
    required init?(rawValue: RawValue) {
        print("rawValue: \(rawValue), what to do?")
    }
    
    init() {
        guard type(of: self) != _AnyStrippedRepresentationBase.self else { fatalError("Use Box class") }
    }
    
    static func == (lhs: _AnyStrippedRepresentationBase<RawValue>, rhs: _AnyStrippedRepresentationBase<RawValue>) -> Bool { abstractMethod() }
    static func < (lhs: _AnyStrippedRepresentationBase<RawValue>, rhs: _AnyStrippedRepresentationBase<RawValue>) -> Bool { abstractMethod()}
    
    var rawValue: RawValue { abstractMethod() }
    var hashValue: Int { abstractMethod() }
}

