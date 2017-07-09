//
//  DuplicatesHandlerManager.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation


extension Attributed {
    
    /// Transforms `[A(1), A(2), A(7)` to `A(x)` where `x` is the selected
    // associated value from the array of duplicate attributes according to
    // the DuplicatesHandler if any, or the default one.
    static func choseDuplicate(from duplicates: [Attribute]) -> Attribute? {
        guard
            let viewAttributes = duplicates as? [ViewAttribute],
            let handler = duplicatesHandler
            else { return duplicates.first }
        //swiftlint:disable force_cast
        print("ExpressibleByAttributes.choseDuplicate - viewAttributes: `\(viewAttributes)` ")
        let chosenAttribute = handler.choseAttributeFromDuplicates(viewAttributes)
        return chosenAttribute as? Attribute
    }
    
    /// Transforms `[ A*: [A(1), A(2), A(7)], C*: [C(2), C(1)] ]` to `[A(x), C(y)]` where `x` and `y` are the
    /// selected associated values from the duplicates according to the DuplicatesHandler if any, or the default one.
    static func choseDuplicates(from duplicatesDictionary: [Attribute.Stripped: [Attribute]]) -> [Attribute] {
        return duplicatesDictionary.values.flatMap { Self.choseDuplicate(from: $0) }
    }
    
    static func removeDuplicatesIfNeededAndAble(_ attributes: [Attribute]) -> [Attribute] {
        guard !attributes.isEmpty else { return [] }
        let grouped = Self.groupAttributes(attributes)
        let duplicates = Dictionary(grouped.filter { $1.count > 1 })
        let selected = Self.choseDuplicates(from: duplicates)
        print(selected)
        print(grouped)
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
