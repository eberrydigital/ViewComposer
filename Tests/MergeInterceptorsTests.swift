//
//  MergeInterceptors.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-06-25.
//
//

import Foundation

import XCTest
@testable import ViewComposer

class MergeInterceptorsTests: BaseXCTest {
    
    func testCustomAttributeMergingOperator() {
        let baseStyle: ViewStyle = [.foo(fooText)]
        let style: ViewStyle = baseStyle <<- .bar(bar)
        guard let foobarViewStyle: FooBarViewStyle = style.value(.custom) else { XCTAssert(false); return }
        XCTAssert(foobarViewStyle.count == 2)
        XCTAssert(foobarViewStyle.value(.bar) == bar)
        XCTAssert(foobarViewStyle.value(.foo) == fooText)
    }
    
    func testCustomAttributeMergingIntercepting() {
        let baseStyle: ViewStyle = [.foo(fooText)]
        let style: ViewStyle = baseStyle.merge(overwrittenBy: .bar(bar))
        guard let foobarViewStyle: FooBarViewStyle = style.value(.custom) else { XCTAssert(false); return }
        XCTAssert(foobarViewStyle.count == 2)
        XCTAssert(foobarViewStyle.value(.bar) == bar)
        XCTAssert(foobarViewStyle.value(.foo) == fooText)
    }
    
    let bar = 237
    func testMasterMergeBetweenEmptyArrayAndDuplicatedCustomAttributesArray() {
        let empty = [ViewAttribute]()
        let merged: ViewStyle = empty.merge(overwrittenBy: [.bar(bar), .foo(fooText)])
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testMasterMergeBetweenEmptyStyleAndDuplicatedCustomAttributesArray() {
        let merged: ViewStyle = ViewStyle([]).merge(overwrittenBy: [.bar(bar), .foo(fooText)])
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testMasterMergeBetweenEmptyArrayAndDuplicatedCustomAttributesStyle() {
        let empty = [ViewAttribute]()
        let merged: ViewStyle = empty.merge(overwrittenBy: ViewStyle([.bar(bar), .foo(fooText)]))
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testMasterMergeBetweenEmptyStyleAndDuplicatedCustomAttributesStyle() {
        let merged: ViewStyle = ViewStyle([]).merge(overwrittenBy: ViewStyle([.bar(bar), .foo(fooText)]))
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    //Using slave
    func testSlaveMergeBetweenEmptyArrayAndDuplicatedCustomAttributesArray() {
        let empty = [ViewAttribute]()
        let merged: ViewStyle = empty.merge(superiorTo: [.bar(bar), .foo(fooText)])
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testSlaveMergeBetweenEmptyStyleAndDuplicatedCustomAttributesArray() {
        let merged: ViewStyle = ViewStyle([]).merge(superiorTo: [.bar(bar), .foo(fooText)])
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testSlaveMergeBetweenEmptyArrayAndDuplicatedCustomAttributesStyle() {
        let empty = [ViewAttribute]()
        let merged: ViewStyle = empty.merge(superiorTo: ViewStyle([.bar(bar), .foo(fooText)]))
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testSlaveMergeBetweenEmptyStyleAndDuplicatedCustomAttributesStyle() {
        let merged: ViewStyle = ViewStyle([]).merge(superiorTo: ViewStyle([.bar(bar), .foo(fooText)]))
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    //MARK: - Using operators
    func testMasterMergeOperatorBetweenEmptyArrayAndDuplicatedCustomAttributesArray() {
        let empty = [ViewAttribute]()
        let merged: ViewStyle = empty <<- [.bar(bar), .foo(fooText)]
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testMasterMergeOperatorBetweenEmptyStyleAndDuplicatedCustomAttributesArray() {
        let merged: ViewStyle = ViewStyle([]) <<- [.bar(bar), .foo(fooText)]
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testMasterMergeOperatorBetweenEmptyArrayAndDuplicatedCustomAttributesStyle() {
        let empty = [ViewAttribute]()
        let merged: ViewStyle = empty <<- ViewStyle([.bar(bar), .foo(fooText)])
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testMasterMergeOperatorBetweenEmptyStyleAndDuplicatedCustomAttributesStyle() {
        let merged: ViewStyle = ViewStyle([]) <<- ViewStyle([.bar(bar), .foo(fooText)])
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    //Using slave
    func testSlaveMergeOperatorBetweenEmptyArrayAndDuplicatedCustomAttributesArray() {
        let empty = [ViewAttribute]()
        let merged: ViewStyle = empty <- [.bar(bar), .foo(fooText)]
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testSlaveMergeOperatorBetweenEmptyStyleAndDuplicatedCustomAttributesArray() {
        let merged: ViewStyle = ViewStyle([]) <- [.bar(bar), .foo(fooText)]
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testSlaveMergeOperatorBetweenEmptyArrayAndDuplicatedCustomAttributesStyle() {
        let empty = [ViewAttribute]()
        let merged: ViewStyle = empty <- ViewStyle([.bar(bar), .foo(fooText)])
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testSlaveMergeOperatorBetweenEmptyStyleAndDuplicatedCustomAttributesStyle() {
        let merged: ViewStyle = ViewStyle([]) <- ViewStyle([.bar(bar), .foo(fooText)])
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    //MARK Single operator
    func testMasterMergeOperatorBetweenSingleAttributes() {
        let merged: ViewStyle =  .bar(bar) <<- .foo(fooText)
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    //using slave
    func testSlaveMergeOperatorBetweenSingleAttributes() {
        let merged: ViewStyle =  .bar(bar) <- .foo(fooText)
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssert(style.count == 2)
        XCTAssert(style.value(.bar) == bar)
        XCTAssert(style.value(.foo) == fooText)
    }
    
    func testSlaveMergeOperatorBetweenSingleAttributesFailesWithoutInterceptor() {
        let merged: ViewStyle =  .bar(bar) <- .foo(fooText)
        guard let style: FooBarViewStyle = merged.value(.custom) else { XCTAssert(false); return }
        XCTAssertFalse(style.count == 2) // fails since no interceptor passed in
    }
}

struct FooBarViewAttributeMerger: AttributesMergable {
    
    static func merge<E: ExpressibleByAttributes>(dominant: E, yielding: E) -> E {
        guard
            let dominantViewStyle = dominant as? ViewStyle,
            let yieldingViewStyle = yielding as? ViewStyle,
            let dominantFooBar: FooBarViewStyle = dominantViewStyle.value(.custom),
            let yieldingFooBar: FooBarViewStyle = yieldingViewStyle.value(.custom)
            else { return dominant.merge(superiorTo: yielding) } //intercept: false
        let merged = dominantFooBar.merge(superiorTo: yieldingFooBar) //intercept: false
        return ViewStyle([.custom(merged)]) as! E
    }
    
    //    static func interceptMerge<A>(dominant dominantAttributed: A, yielding yieldingAttributed: A) -> A where A : Attributed {
    //        guard
    //            let master = dominantAttributed as? ViewStyle,
    //            let slave = yieldingAttributed as? ViewStyle,
    //            let dominantFooBar: FooBarViewStyle = master.value(.custom),
    //            let yieldingFooBar: FooBarViewStyle = slave.value(.custom)
    //            else { return dominantAttributed.merge(yieldingAttributed, prefer: .left, intercept: false) }
    //        let merged = dominantFooBar.merge(yieldingFooBar, prefer: .left, intercept: false)
    //        return ViewStyle([.custom(merged)]) as! A
    //    }
}

public enum FooBarViewAttribute {
    case foo(String)
    case bar(Int)
}

protocol FooBarViewStyleable {
    var foo: String? { get set }
    var bar: Int? { get set }
}

extension UITextField: FooBarViewStyleable {
    
    var foo: String? {
        set { placeholder = newValue }
        get { return placeholder }
    }
    
    var bar: Int? {
        set { text = "\(newValue!)" }
        get {
            guard let text = text else { return nil }
            return Int(text)
        }
    }
}

extension ViewAttribute {
    static func foo(_ foo: String) -> ViewAttribute {
        return .foobar(.foo(foo))
    }
    
    static func bar(_ bar: Int) -> ViewAttribute {
        return .foobar(.bar(bar))
    }
    
    static func foobar(_ attribute: FooBarViewAttribute) -> ViewAttribute {
        return .custom(FooBarViewStyle([attribute]))
    }
}

public struct FooBarViewStyle: Attributed {
    
    public var startIndex: Int = 0
    public var attributes: [FooBarViewAttribute]
    
    public init(attributes: [FooBarViewAttribute]) {
        self.attributes = attributes
    }
    
    public init(arrayLiteral elements: FooBarViewAttribute...) {
        self.attributes = elements
    }
    
    public func install(on styleable: Any) {
        guard var fooBarStyleable = styleable as? FooBarViewStyleable else { return }
        attributes.forEach {
            switch $0 {
            case .foo(let foo):
                fooBarStyleable.foo = foo
            case .bar(let bar):
                fooBarStyleable.bar = bar
            }
        }
    }
}

//MARK: Making FooBarViewAttribute AssociatedValueStrippable, typically we want to automate this using `Sourcery`...
extension FooBarViewAttribute: Equatable {
    public static func == (lhs: FooBarViewAttribute, rhs: FooBarViewAttribute) -> Bool {
        return lhs.stripped == rhs.stripped
    }
}

extension FooBarViewAttribute: AssociatedValueEnumExtractor {
    public var associatedValue: Any? {
        switch self {
        case .foo(let foo):
            return foo
        case .bar(let bar):
            return bar
        }
    }
}

extension FooBarViewAttribute: AssociatedValueStrippable {
    public typealias Stripped = FooBarViewAttributeStripped
    public var stripped: Stripped {
        let stripped: Stripped
        switch self {
        case .foo:
            stripped = .foo
        case .bar:
            stripped = .bar
        }
        return stripped
    }
}

public enum FooBarViewAttributeStripped: String, StrippedRepresentation {
    case foo, bar
}

