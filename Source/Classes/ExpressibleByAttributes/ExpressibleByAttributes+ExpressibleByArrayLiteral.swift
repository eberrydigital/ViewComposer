//
//  ExpressibleByAttributes+ExpressibleByArrayLiteral.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

extension ExpressibleByAttributes {
    public init(arrayLiteral elements: Attribute...) {
        self.init(Self.removeDuplicatesIfNeededAndAble(elements))
    }
}

