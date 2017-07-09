//
//  AssociatedValueStrippable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public protocol AssociatedValueEnumExtractor {
    var associatedValue: Any? { get }
}

public protocol StringRawValueRepresentable: RawRepresentable {}

public extension StringRawValueRepresentable {
    typealias RawValue = String
}

public protocol StrippedRepresentation: StringRawValueRepresentable, Equatable, Hashable, Comparable {}
public protocol AssociatedValueStrippable: Equatable, Comparable {
    associatedtype Stripped: StrippedRepresentation
    var stripped: Stripped { get }
}

public typealias AttributeType = AssociatedValueStrippable & AssociatedValueEnumExtractor
