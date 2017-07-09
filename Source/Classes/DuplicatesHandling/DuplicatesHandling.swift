//
//  DuplicatesHandling.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

//swiftlint:disable generic_type_name

public typealias SingleAttributeTransformer<Attributed: ExpressibleByAttributes, CustomAttributed: ExpressibleByAttributes> = (Attributed.Attribute) -> CustomAttributed?
public typealias AttributesTransformer<CustomAttributed: ExpressibleByAttributes, Attributed: ExpressibleByAttributes> = ([CustomAttributed.Attribute]) -> CustomAttributed

public typealias AttributedTransformer<CustomAttributed: ExpressibleByAttributes, Attributed: ExpressibleByAttributes> = (CustomAttributed) -> Attributed.Attribute

//public protocol CustomAttributedToAttributeTransformer {
//    associatedtype Attribute: AttributeType
//    associatedtype Custom: ExpressibleByAttributes
//    func transformCustomAttributedToAttribute(custom customAttributed: Custom) -> Attribute
//}
//
////swiftlint:disable type_name
//public struct AnyCustomAttributedToAttributeTransformer {
//    private let _transformCustomAttributedToAttribute: (AnyExpressibleByAttributes) -> AnyAttribute
//    
//    public init<Concrete: CustomAttributedToAttributeTransformer>(_ concrete: Concrete) where Concrete.Attribute.Stripped.RawValue == String, Concrete.Custom.Attribute.Stripped.RawValue == String {
//        
//        _transformCustomAttributedToAttribute = { (custom: Concrete.Custom) in
//            let attribute: Concrete.Attribute = concrete.transformCustomAttributedToAttribute(custom: custom)
//            return AnyAttribute(attribute)
//        }
//    }
//    
//    public func transformCustomAttributedToAttribute(custom customAttributed: AnyExpressibleByAttributes) -> AnyAttribute {
//        return _transformCustomAttributedToAttribute(customAttributed)
//    }
//}

public protocol BaseToCustomTransformer {
    associatedtype Custom: ExpressibleByAttributes
    func transformBaseToCustom(base baseAttributed: BaseAttributed) -> Custom
}

public struct AnyBaseToCustomTransformer: BaseToCustomTransformer {
    private let _transformBaseToCustom: (BaseAttributed) -> AnyExpressibleByAttributes
    public init<Concrete: BaseToCustomTransformer>(_ concrete: Concrete) where Concrete.Custom.Attribute.Stripped.RawValue == String {
        _transformBaseToCustom = { return AnyExpressibleByAttributes(concrete.transformBaseToCustom(base: $0)) }
    }
    public func transformBaseToCustom(base baseAttributed: BaseAttributed) -> AnyExpressibleByAttributes {
        return _transformBaseToCustom(baseAttributed)
    }
}

public protocol DuplicatesHandling {
    associatedtype Attributed: ExpressibleByAttributes
    associatedtype CustomAttributed: ExpressibleByAttributes
    
    var singleAttributeTransformer: SingleAttributeTransformer<Attributed, CustomAttributed> { get }
    var attributesTransformer: AttributesTransformer<CustomAttributed, Attributed> { get }
    var attributedTransformer: AttributedTransformer<CustomAttributed, Attributed> { get }
    
    func choseAttributeFromDuplicates(_ duplicates: [Attributed.Attribute]) -> Attributed.Attribute
}

extension DuplicatesHandling {
    
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

public protocol ViewStyleDuplicatesHandling: DuplicatesHandling {
    associatedtype Attributed = ViewStyle
    var baseAttributedTransformer: AnyBaseToCustomTransformer { get }
    var _attributesTransformer: AttributesTransformer<CustomAttributed, ViewStyle> { get }
    var _attributedTransformer: AttributedTransformer<CustomAttributed, ViewStyle> { get }
}

extension ViewStyleDuplicatesHandling {
    public var singleAttributeTransformer: SingleAttributeTransformer<ViewStyle, CustomAttributed> {
        return { (viewAttribute: ViewAttribute) in
            guard let custom = viewAttribute.custom else { return nil }
            return self.baseAttributedTransformer.transformBaseToCustom(base: custom) as? Self.CustomAttributed
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

    public var baseAttributedTransformer: AnyBaseToCustomTransformer
    
    public init(baseAttributedTransformer: AnyBaseToCustomTransformer) {
        self.baseAttributedTransformer = baseAttributedTransformer
    }
}

protocol ViewStyleDuplicatesHandleCapable {
    associatedtype Custom: ExpressibleByAttributes
    func transformToCustom(_ attribute: ViewAttribute) -> Custom?
//    var makeCustom: (([Custom.Attribute]) -> Custom) { get }
    func transformCustomAttributesToCustom(_ customAttributes: [Custom.Attribute]) -> Custom
    func choseAttributeFromDuplicates(_ duplicates: [ViewAttribute]) -> ViewAttribute
}

extension ViewStyleDuplicatesHandleCapable {
    func transformCustomAttributesToCustom(_ customAttributes: [Custom.Attribute]) -> Custom {
        return Custom(customAttributes)
    }
    
    func transformToViewAttribute(_ custom: Custom) -> ViewAttribute {
        return ViewAttribute.custom(custom)
    }
    
    func choseAttributeFromDuplicates(_ duplicates: [ViewAttribute]) -> ViewAttribute {
        var customAttributes: [Custom.Attribute] = []
        for attribute in duplicates {
            guard let customStyle = transformToCustom(attribute) else { continue }
            customAttributes.append(contentsOf: customStyle.attributes)
            
        }
        let custom = transformCustomAttributesToCustom(customAttributes)
        return transformToViewAttribute(custom)
    }
}

public struct TypedViewStyleDuplicatesHandler<_Custom: ExpressibleByAttributes>: ViewStyleDuplicatesHandleCapable {
    
    typealias Custom = _Custom
    
    private let makeCustom: (([Custom.Attribute]) -> Custom)
    
    init(makeCustom: @escaping (([Custom.Attribute]) -> Custom)) {
        self.makeCustom = makeCustom
    }
    
    func transformToCustom(_ attribute: ViewAttribute) -> Custom? {
        let customAttribute = attribute.custom
        guard let custom = customAttribute as? Custom else { return nil }
        return custom
    }
    
    func transformCustomAttributesToCustom(_ customAttributes: [Custom.Attribute]) -> Custom {
        return makeCustom(customAttributes)
    }
}

public struct AnyDuplicatesHandler: ViewStyleDuplicatesHandleCapable {
    
    private let _transformToCustom: (ViewAttribute) -> AnyExpressibleByAttributes?
    
    init<Base: ViewStyleDuplicatesHandleCapable>(_ base: Base) where Base.Custom.Attribute.Stripped.RawValue == String {
        _transformToCustom = { guard let custom = base.transformToCustom($0) else { return nil }; return AnyExpressibleByAttributes(custom) }
    }
    
    func transformToCustom(_ attribute: ViewAttribute) -> AnyExpressibleByAttributes? {
        return _transformToCustom(attribute)
    }
}

//
//
//public struct AnyViewStyleDuplicatesHandler: ViewStyleDuplicatesHandling {
//    /*
//    associatedtype Attributed: ExpressibleByAttributes
//    associatedtype CustomAttributed: ExpressibleByAttributes
//    
//    var singleAttributeTransformer: SingleAttributeTransformer<Attributed, CustomAttributed> { get }
//    var attributesTransformer: AttributesTransformer<CustomAttributed, Attributed> { get }
//    var attributedTransformer: AttributedTransformer<CustomAttributed, Attributed> { get }
//     
//     var baseAttributedTransformer: AnyBaseToCustomTransformer { get }
//    */
//    
//    private let _getBaseAttributedTransformer: () -> AnyBaseToCustomTransformer
//    public var baseAttributedTransformer: AnyBaseToCustomTransformer { return _getBaseAttributedTransformer() }
//    
//    init<Base: ViewStyleDuplicatesHandling>(_ base: Base) where Base.CustomAttributed.Attribute.Stripped.RawValue == String {
//        _getBaseAttributedTransformer = { base.baseAttributedTransformer }
//    }
//    
//}
