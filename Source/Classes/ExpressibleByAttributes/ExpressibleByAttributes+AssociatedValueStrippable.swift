//
//  ExpressibleByAttributes+AssociatedValueStrippable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public extension ExpressibleByAttributes {
    typealias Stripped = Attribute.Stripped
    var stripped: [Stripped] { return attributes.map { $0.stripped } }
}
