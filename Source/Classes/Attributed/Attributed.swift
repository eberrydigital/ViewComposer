//
//  Attributed.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-05-31.
//
//

import Foundation

public protocol AssociatedValueEnumExtractor {
    var associatedValue: Any? { get }
}

public protocol StrippedRepresentation: RawRepresentable, Equatable, Hashable, Comparable {}
public protocol AssociatedValueStrippable: Equatable, Comparable {
    associatedtype Stripped: StrippedRepresentation
    var stripped: Stripped { get }
}

/// Type that holds a collection of attributes used to style some `Styleable`. 
/// This collection can be merged with another instance of it sharing the same `Attribute` associatedtype.
/// You can also extract values associated to a certain attribute e.g. the `UIColor` associated to the attribute `backgroundColor`.
public protocol Attributed: Collection, ExpressibleByArrayLiteral, BaseAttributed {
    
    /// `Attribute` type used to style. Needs conformancs to `AssociatedValueStrippable` and `AssociatedValueEnumExtractor` 
    /// so that we can perform merging operations and also logic such as `contains:attribute` and `value` extraction,
    /// accessing the value associated to a certain attribute. e.g. the `UIColor` associated to the attribute `backgroundColor`
    associatedtype Attribute: AssociatedValueStrippable, AssociatedValueEnumExtractor
    
    init(_ attributes: [Attribute])
    
    /// Attributes used to style some `Styleable` type
    var attributes: [Attribute] { get }
    
    /// Needed for conformance to `Collection`
    var startIndex: Int { get }
    
    //MARK: - Merging methods
    func merge(slave: Self, intercept: Bool) -> Self
    func merge(master: Self, intercept: Bool) -> Self
    
    func merge(slave: [Attribute], intercept: Bool) -> Self
    func merge(master: [Attribute], intercept: Bool) -> Self
    
    func merge(slave: Attribute, intercept: Bool) -> Self
    func merge(master: Attribute, intercept: Bool) -> Self
    
    static var mergeInterceptors: [MergeInterceptor.Type] { get set }
    static var duplicatesHandler: AnyDuplicatesHandler<Self>? { get set }
    
    //MARK: - Collection associatedtypes
    associatedtype Index = Int
    associatedtype Iterator = IndexingIterator<Self>
    associatedtype Indices = DefaultIndices<Self>
}

public protocol DuplicatesHandler {
    associatedtype AttributedType: Attributed
    func choseDuplicate(from duplicates: [AttributedType.Attribute]) -> AttributedType.Attribute
}

//swiftlint:disable generic_type_name
public struct AnyDuplicatesHandler<_Attributed: Attributed>: DuplicatesHandler {
    public typealias AttributedType = _Attributed
    
    var _chooseDuplicate: ([AttributedType.Attribute]) -> AttributedType.Attribute

    init<D: DuplicatesHandler>(_ concrete: D) where D.AttributedType == AttributedType {
        _chooseDuplicate = { duplicatess in concrete.choseDuplicate(from: duplicatess) }
    }
    
    public func choseDuplicate(from duplicates: [AttributedType.Attribute]) -> AttributedType.Attribute { return _chooseDuplicate(duplicates) }
}

extension Attributed {
    
    /// Transforms `[A(1), A(2), A(7)` to `A(x)` where `x` is the selected 
    // associated value from the array of duplicate attributes according to 
    // the DuplicatesHandler if any, or the default one.
    static func choseDuplicate(from duplicates: [Attribute]) -> Attribute? {
        guard let duplicatesHandler = duplicatesHandler else { return duplicates.first }
        return duplicatesHandler.choseDuplicate(from: duplicates)
    }
    
    /// Transforms `[ A*: [A(1), A(2), A(7)], C*: [C(2), C(1)] ]` to `[A(x), C(y)]` where `x` and `y` are the
    /// selected associated values from the duplicates according to the DuplicatesHandler if any, or the default one.
    static func choseDuplicates(from duplicatesDictionary: [Attribute.Stripped: [Attribute]]) -> [Attribute] {
        return duplicatesDictionary.values.flatMap { Self.choseDuplicate(from: $0) }
    }
    
    static func removeDuplicatesIfNeededAndAble(_ attributes: [Attribute]) -> [Attribute] {
        let grouped = Self.groupAttributes(attributes)
        let duplicates = Dictionary(grouped.filter { $1.count > 1 })
        let selected = Self.choseDuplicates(from: duplicates)
        return selected + grouped.values.filter { $0.count == 1 }.flatMap { $0 }
    }
}

extension Attributed {

    /// Groups together attributes with same key returns those attributes which has
    /// duplicates values. Attributes with no duplicates are also returned, contained
    // in an array with the length of one. So given the attributes array:
    /// `[A(1), A(2), C(2), B(6), C(1), A(7)]` this method would return
    /// `[ A*: [A(1), A(2), A(7)], B*: [B(6)], C*: [C(2), C(1)] ]` where `X*` is the stripped representation
    /// of the attribute `X`.
    ///
    /// - Parameter attributes: Attributes array to process
    /// - Returns: dictionary where keys are stripped representation of attribute with duplicates. The value
    // for the key is an array of all Attribute(associatedValue).
    static func groupAttributes(_ attributes: [Attribute]) -> [Attribute.Stripped: [Attribute]] {
        var grouped: [Attribute.Stripped: [Attribute]] = [:]
        
        for attribute in attributes {
            let key = attribute.stripped
            var value = grouped[key] ?? []
            value.append(attribute)
            grouped[key] = value
        }
        return grouped
    }
}

//MARK: - ExpressibleByArrayLiteral
extension Attributed {
    public init(arrayLiteral elements: Attribute...) {
        self.init(Self.removeDuplicatesIfNeededAndAble(elements))
    }
}

public protocol MergeInterceptor {
    static func interceptMerge<A: Attributed>(master: A, slave: A) -> A
}
