//
//  AnyDuplicatesHandler.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

//public typealias ToStyle<CustomAttributed: ExpressibleByAttributes, Attributed: ExpressibleByAttributes> = ([CustomAttributed.Attribute]) -> Attributed.Attribute
//public typealias ToCustomStyle<Attributed: ExpressibleByAttributes, CustomAttributed: ExpressibleByAttributes> = ([Attributed.Attribute]) -> [CustomAttributed]
//      var toStyle: ToStyle<CustomAttributed, Attributed> { get }
//      var toCustomStyle: ToCustomStyle<Attributed, CustomAttributed> { get }

//swiftlint:disable generic_type_name
public struct AnyDuplicatesHandler<StyleStripped: StrippedRepresentation, CustomStripped: StrippedRepresentation>: DuplicatesHandling {
    public typealias Attributed = AnyExpressibleByAttributes<AnyAssociatedValueStrippable<StyleStripped>>
    public typealias CustomAttributed = AnyExpressibleByAttributes<AnyAssociatedValueStrippable<CustomStripped>>
    public var toStyle: ToStyle<CustomAttributed, Attributed> { return box.toStyle }
    public var toCustomStyle: ToCustomStyle<Attributed, CustomAttributed> { return box.toCustomStyle }
    
    private let box: _AnyDuplicatesHandlerBase<StyleStripped, CustomStripped>
    
    public init<Concrete: DuplicatesHandling>(_ concrete: Concrete) where Concrete.Attributed.Attribute.Stripped == StyleStripped, Concrete.CustomAttributed.Attribute.Stripped == CustomStripped {
        box = _AnyDuplicatesHandlerBox(concrete)
    }
}

private final class _AnyDuplicatesHandlerBox<Concrete: DuplicatesHandling>: _AnyDuplicatesHandlerBase<Concrete.Attributed.Attribute.Stripped, Concrete.CustomAttributed.Attribute.Stripped> {
    
    private var concrete: Concrete
    init(_ concrete: Concrete) {
        self.concrete = concrete
    }
    
//    override var toStyle: ToStyle<CustomAttributed, Attributed> { return concrete.toStyle }
//    override var toCustomStyle: ToCustomStyle<Attributed, CustomAttributed> { return concrete.toCustomStyle }
}

private class _AnyDuplicatesHandlerBase<StyleStripped: StrippedRepresentation, CustomStripped: StrippedRepresentation>: DuplicatesHandling {
    typealias Attributed = AnyExpressibleByAttributes<AnyAssociatedValueStrippable<StyleStripped>>
    typealias CustomAttributed = AnyExpressibleByAttributes<AnyAssociatedValueStrippable<CustomStripped>>
    var toStyle: ToStyle<CustomAttributed, Attributed> { abstractMethod() }
    var toCustomStyle: ToCustomStyle<Attributed, CustomAttributed> { abstractMethod() }
    
    init() {
        guard type(of: self) != _AnyDuplicatesHandlerBase.self else { fatalError("Use Box class") }
    }
}



