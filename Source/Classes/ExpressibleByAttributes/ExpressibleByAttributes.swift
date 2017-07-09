//
//  ExpressibleByAttributes.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public protocol ExpressibleByAttributes: BaseAttributed, CustomStringConvertible {
    /// `Attribute` type used to style. Needs conformancs to `AssociatedValueStrippable` and `AssociatedValueEnumExtractor`
    /// so that we can perform merging operations and also logic such as `contains:attribute` and `value` extraction,
    /// accessing the value associated to a certain attribute. e.g. the `UIColor` associated to the attribute `backgroundColor`
    associatedtype Attribute: AttributeType
    
    /// Attributes used to style some `Styleable` type
    var attributes: [Attribute] { get }
}
//
//extension ExpressibleByAttributes {
//    public var domainTranslator: DomainTranslator? { return nil }
//}

extension Attributed {
    public init(_ elements: [Attribute]) {
        self.init(attributes: Self.removeDuplicatesIfNeededAndAble(elements))
    }
}
//
//public protocol DomainTranslator {
//    func translate<E: ExpressibleByAttributes>(base: BaseAttributed) -> E?
//}
//
//extension ViewStyle {
//    var translation: (BaseAttributed) -> ExpressibleByAttributes
//    var domainTranslator: DomainTranslator? { return ViewStyleDomainTranslator() }
//}
//
//struct ViewStyleDomainTranslator: DomainTranslator {}
