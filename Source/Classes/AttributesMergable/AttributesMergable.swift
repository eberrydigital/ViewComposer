//
//  AttributesMergable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public protocol AttributesMergable {
    static func merge<E: ExpressibleByAttributes>(dominant: E, yielding: E) -> E
}
