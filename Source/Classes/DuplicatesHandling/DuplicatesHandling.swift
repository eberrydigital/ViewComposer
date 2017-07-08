//
//  DuplicatesHandling.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public typealias BaseAttributedTransformer<CustomAttributed: ExpressibleByAttributes> = (BaseAttributed) -> CustomAttributed?
public typealias SingleAttributeTransformer<Attributed: ExpressibleByAttributes, CustomAttributed: ExpressibleByAttributes> = (Attributed.Attribute) -> CustomAttributed?
public typealias AttributesTransformer<CustomAttributed: ExpressibleByAttributes, Attributed: ExpressibleByAttributes> = ([CustomAttributed.Attribute]) -> CustomAttributed

public typealias AttributedTransformer<CustomAttributed: ExpressibleByAttributes, Attributed: ExpressibleByAttributes> = (CustomAttributed) -> Attributed.Attribute

public protocol DuplicatesHandlingAssociated {
    associatedtype Attributed: ExpressibleByAttributes
    associatedtype CustomAttributed: ExpressibleByAttributes
    
    var singleAttributeTransformer: SingleAttributeTransformer<Attributed, CustomAttributed> { get }
    var attributesTransformer: AttributesTransformer<CustomAttributed, Attributed> { get }
    var attributedTransformer: AttributedTransformer<CustomAttributed, Attributed> { get }
    
    func choseAttributeFromDuplicates(_ duplicates: [Attributed.Attribute]) -> Attributed.Attribute
}

extension DuplicatesHandlingAssociated {
    
    public typealias Attribute = Attributed.Attribute
    public typealias CustomAttribute = CustomAttributed.Attribute
    
    public func choseAttributeFromDuplicates(_ duplicates: [Attribute]) -> Attribute {
        var customAttributes = [CustomAttribute]()
        let customStyles: [CustomAttributed] = duplicates.flatMap(singleAttributeTransformer)
        customStyles.forEach {
            customAttributes.append(contentsOf: $0.attributes)
        }
        let customStyle: CustomAttributed = attributesTransformer(customAttributes)
        return attributedTransformer(customStyle)
    }
}

public protocol ViewStyleDuplicatesHandling: DuplicatesHandlingAssociated {
    associatedtype Attributed = ViewStyle
    var baseAttributedTransformer: BaseAttributedTransformer<CustomAttributed> { get }
    var _attributesTransformer: AttributesTransformer<CustomAttributed, ViewStyle> { get }
    var _attributedTransformer: AttributedTransformer<CustomAttributed, ViewStyle> { get }
}

extension ViewStyleDuplicatesHandling {
    public var singleAttributeTransformer: SingleAttributeTransformer<ViewStyle, CustomAttributed> {
        return { (viewAttribute: ViewAttribute) in
            guard let custom = viewAttribute.custom else { return nil }
            return self.baseAttributedTransformer(custom)
        }
    }
    
    public var attributesTransformer: AttributesTransformer<CustomAttributed, ViewStyle> {
        return _attributesTransformer
    }
    
    public var attributedTransformer: AttributedTransformer<CustomAttributed, ViewStyle> {
        return _attributedTransformer
    }
}

extension ViewStyleDuplicatesHandling {
    
    public var _attributesTransformer: AttributesTransformer<CustomAttributed, ViewStyle> {
        return { customAttributes in return CustomAttributed(customAttributes) }
    }
    
    public var _attributedTransformer: AttributedTransformer<CustomAttributed, ViewStyle> {
        return { customStyle in return ViewAttribute.custom(customStyle) }
    }
}

public struct ViewStyleDuplicatesHandler<CustomStyle: ExpressibleByAttributes>: ViewStyleDuplicatesHandling {
    public typealias Attributed = ViewStyle

    public typealias CustomAttributed = CustomStyle

    public var baseAttributedTransformer: BaseAttributedTransformer<CustomAttributed>
    
    public init(baseAttributedTransformer: @escaping BaseAttributedTransformer<CustomAttributed>) {
        self.baseAttributedTransformer = baseAttributedTransformer
    }
}

//ViewStyleDuplicatesHandler<AnyExpressibleByAttributes<AnyAssociatedValueStrippable<AnyStrippedRepresentation<String>>>>
public struct AnyViewStyleDuplicatesHandler<CustomStyle: ExpressibleByAttributes>: ViewStyleDuplicatesHandling {
    public typealias Attributed = ViewStyle

    public typealias CustomAttributed = CustomStyle

    var _baseAttributedTransformer: BaseAttributedTransformer<CustomStyle>
    
    public var baseAttributedTransformer: BaseAttributedTransformer<CustomStyle> {
        return _baseAttributedTransformer
    }
    
    public init<Concrete: ViewStyleDuplicatesHandling>(_ concrete: Concrete) where Concrete.CustomAttributed == CustomStyle {
        _baseAttributedTransformer = concrete.baseAttributedTransformer
    }
}

