//
//  DuplicatesHandling.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

//swiftlint:disable generic_type_name
protocol ViewStyleDuplicatesHandleCapable {
    associatedtype Custom: ExpressibleByAttributes
    func transformToCustom(_ attribute: ViewAttribute) -> Custom?
    var makeCustom: (([Custom.Attribute]) -> Custom) { get }
    func choseAttributeFromDuplicates(_ duplicates: [ViewAttribute]) -> ViewAttribute
}

extension ViewStyleDuplicatesHandleCapable {
    
    func transformToViewAttribute(_ custom: Custom) -> ViewAttribute {
        return ViewAttribute.custom(custom)
    }
    
    func choseAttributeFromDuplicates(_ duplicates: [ViewAttribute]) -> ViewAttribute {
        var customAttributes: [Custom.Attribute] = []
        for attribute in duplicates {
            guard let customStyle = transformToCustom(attribute) else { continue }
            customAttributes.append(contentsOf: customStyle.attributes)
            
        }
        let custom = makeCustom(customAttributes)
        return transformToViewAttribute(custom)
    }
}

public struct TypedViewStyleDuplicatesHandler<_Custom: ExpressibleByAttributes>: ViewStyleDuplicatesHandleCapable {
    
    typealias Custom = _Custom
    
    let makeCustom: (([Custom.Attribute]) -> Custom)
    
    init(makeCustom: @escaping (([Custom.Attribute]) -> Custom)) {
        self.makeCustom = makeCustom
    }
    
    func foo<F: ExpressibleByAttributes>(_ fooAttributes: [F.Attribute]) -> F {
        fatalError("how foo")
    }
    
    func transformToCustom(_ attribute: ViewAttribute) -> Custom? {
        switch attribute {
        case .custom(let customAnyExpressibleByArrayAttributes):
            if let customStyle = customAnyExpressibleByArrayAttributes as? Custom {
                print("Epic win!")
                return customStyle
            } else {
                print("was case .custom, but failed to cast, due to information loss, due to Type Erasure")
                return nil
            }
        default:
            print("not case .custom")
            return nil
        }
    }
    
    func transformCustomAttributesToCustom(_ customAttributes: [Custom.Attribute]) -> Custom {
        return makeCustom(customAttributes)
    }
}

public struct AnyDuplicatesHandler<_Custom: ExpressibleByAttributes>: ViewStyleDuplicatesHandleCapable {
    
    public typealias Custom = _Custom
    
    private let _transformToCustom: (ViewAttribute) -> Custom?
    private let _makeCustom: (([Custom.Attribute]) -> Custom)
    
    init<Base: ViewStyleDuplicatesHandleCapable>(_ base: Base) where Base.Custom == Custom {
//        _transformToCustom = { guard let custom = base.transformToCustom($0) else { return nil }; return AnyExpressibleByAttributes(custom) }
        _transformToCustom = { base.transformToCustom($0) }
        _makeCustom = { base.makeCustom($0) }
        guard let typed = base as? TypedViewStyleDuplicatesHandler<Custom> else { return }
        _foo = { typed.foo($0) }
    }
    
    public func transformToCustom(_ attribute: ViewAttribute) -> Custom? {
        return _transformToCustom(attribute)
    }
    
    public var makeCustom: (([Custom.Attribute]) -> Custom) {
        return _makeCustom
    }
    
    typealias FooTyped<F: ExpressibleByAttributes> = ([F.Attribute]) -> F
    private var _foo: FooTyped<Custom>?
    
    func foo<F: ExpressibleByAttributes>(_ fooAttributes: [F.Attribute]) -> F {
        guard let fooStored = _foo else { fatalError("how foo") }
        //swiftlint:disable force_cast
        return fooStored(fooAttributes as! [Custom.Attribute])
    }
}
