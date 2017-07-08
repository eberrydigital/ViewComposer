//
//  DuplicatesHandling.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public protocol DuplicatesHandling {
    
    static func toStyle<CustomAttribute: AttributeType, Attribute: AttributeType>(_ source: [CustomAttribute]) -> Attribute
    
    static func toCustomStyle<Attribute: AttributeType, CustomAttribute: AttributeType>(_ source: [Attribute]) -> [AnyExpressibleByAttributes<CustomAttribute>]
    
    static func choseDuplicate<Attribute: AttributeType, CustomAttribute: AttributeType>(from duplicates: [Attribute], anyCustomAttributed: AnyExpressibleByAttributes<CustomAttribute>.Type) -> Attribute
}

extension DuplicatesHandling {
    
    public static func choseDuplicate<Attribute: AttributeType, CustomAttribute: AttributeType>(from duplicates: [Attribute], anyCustomAttributed: AnyExpressibleByAttributes<CustomAttribute>.Type) -> Attribute {
        
        var customAttributes: [CustomAttribute] = []
        let customStyles: [AnyExpressibleByAttributes<CustomAttribute>] = toCustomStyle(duplicates)
        customStyles.forEach {
            customAttributes.append(contentsOf: $0.attributes)
        }
        return toStyle(customAttributes)
    }
}

