//
//  ExpressibleByAttributes.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public protocol ExpressibleByAttributes: BaseAttributed, ExpressibleByArrayLiteral, CustomStringConvertible {
    /// `Attribute` type used to style. Needs conformancs to `AssociatedValueStrippable` and `AssociatedValueEnumExtractor`
    /// so that we can perform merging operations and also logic such as `contains:attribute` and `value` extraction,
    /// accessing the value associated to a certain attribute. e.g. the `UIColor` associated to the attribute `backgroundColor`
    associatedtype Attribute: AttributeType
    
    init(attributes: [Attribute])
    
    /// Attributes used to style some `Styleable` type
    var attributes: [Attribute] { get set }
}

extension ExpressibleByAttributes {
    public init(_ elements: [Attribute]) {
        self.init(attributes: Self.removeDuplicatesIfNeededAndAble(elements))
    }
}

