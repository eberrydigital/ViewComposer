//
//  AnyStrippedRepresentation.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-08.
//

import Foundation

public struct StringRawRepresentable: StringRawValueRepresentable {
    
    public init?(rawValue: String) { fatalError("Use Base init") }
    
    private var _getRawValue: () -> String
    
    public var rawValue: String { return _getRawValue() }
    
    init<Base: StringRawValueRepresentable>(_ base: Base) {
        //swiftlint:disable:next force_cast
        _getRawValue = { base.rawValue as! String }
    }
}

public struct AnyStrippedRepresentation: StrippedRepresentation {

    public init?(rawValue: StringRawRepresentable) {
        fatalError("use Base init")
    }

    private let _getRawValue: () -> StringRawRepresentable
    private let _getHashValue: () -> Int

    public var rawValue: StringRawRepresentable { return _getRawValue() }
    public var hashValue: Int { return _getHashValue() }
    
    init<Base: StrippedRepresentation>(_ base: Base) {
        _getRawValue = { StringRawRepresentable(base) }
        _getHashValue = { base.hashValue }
    }
    
    public static func == (lhs: AnyStrippedRepresentation, rhs: AnyStrippedRepresentation) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    public static func < (lhs: AnyStrippedRepresentation, rhs: AnyStrippedRepresentation) -> Bool {
        return lhs.rawValue.rawValue < rhs.rawValue.rawValue
    }
}
