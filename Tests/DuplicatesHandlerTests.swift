//
//  DuplicatesHandlerTests.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-06-25.
//
//

import Foundation

import XCTest
@testable import ViewComposer
class DuplicatesHandlerTests: BaseXCTest {
    
    override func setUp() {
        super.setUp()
        
        ViewStyle.duplicatesHandler = AnyDuplicatesHandler(TypedViewStyleDuplicatesHandler<ViewStyle>() {
            print("DuplicatesHandler - attributes: `\($0)`")
            return FooBarViewStyle($0)
        })
    }
    
    func testCustomAttributeDuplicatesInstantiation() {
        
        let bar = 237
        let style: ViewStyle = [.foo(fooText), .bar(bar)]
        print("Style: `\(style)`")
        guard let foobarViewStyle: FooBarViewStyle = style.value(.custom) else { XCTAssert(false); return }
        XCTAssert(foobarViewStyle.count == 2)
        XCTAssert(foobarViewStyle.value(.bar) == bar)
        XCTAssert(foobarViewStyle.value(.foo) == fooText)
    }
    
    func testMakeableDuplicatesHandlerAlongSideStandardAttributes() {
        
        let bar = 237
        let field: UITextField = [.foo(fooText), .bar(bar), .color(.red), .cornerRadius(cornerRadius)]
        assertIs(field.placeholder, is: fooText)
        assertIs(field.text, is: "\(bar)")
        assertIs(field.backgroundColor, is: .red)
        assertIs(field.layer.cornerRadius, is: cornerRadius)
        
    }
}

