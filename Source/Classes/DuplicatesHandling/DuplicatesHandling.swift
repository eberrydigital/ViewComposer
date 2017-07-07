//
//  DuplicatesHandling.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public typealias ToStyle<CustomAttributed: ExpressibleByAttributes, Attributed: ExpressibleByAttributes> = ([CustomAttributed.Attribute]) -> Attributed.Attribute
public typealias ToCustomStyle<Attributed: ExpressibleByAttributes, CustomAttributed: ExpressibleByAttributes> = ([Attributed.Attribute]) -> [CustomAttributed]

public protocol DuplicatesHandling {
    associatedtype Attributed: ExpressibleByAttributes
    associatedtype CustomAttributed: ExpressibleByAttributes
    
    var toStyle: ToStyle<CustomAttributed, Attributed> { get }
    var toCustomStyle: ToCustomStyle<Attributed, CustomAttributed> { get }
    
    func choseDuplicate(from duplicates: [Attributed.Attribute], targetAttribute: Attributed.Attribute) -> Attributed.Attribute
}

extension DuplicatesHandling {
    
    public typealias Attribute = Attributed.Attribute
    public typealias CustomAttribute = CustomAttributed.Attribute
    
    public func choseDuplicate(from duplicates: [Attribute], targetAttribute: Attribute) -> Attribute {
        var customAttributes: [CustomAttribute] = []
        let customStyles: [CustomAttributed] = toCustomStyle(duplicates)
        customStyles.forEach {
            customAttributes.append(contentsOf: $0.attributes)
        }
        return toStyle(customAttributes)
    }
}

public struct DuplicatesHandler<Style: ExpressibleByAttributes, CustomStyle: ExpressibleByAttributes>: DuplicatesHandling {
    public typealias Attributed = Style
    public typealias CustomAttributed = CustomStyle
    public let toStyle: ToStyle<CustomStyle, Style>
    public let toCustomStyle: ToCustomStyle<Style, CustomStyle>
    
    public init(toStyle: @escaping ToStyle<CustomStyle, Style>, toCustomStyle: @escaping ToCustomStyle<Style, CustomStyle>) {
        self.toStyle = toStyle
        self.toCustomStyle = toCustomStyle
    }
}

