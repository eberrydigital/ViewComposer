//
//  ExpressibleByAttributes+Array+AssociatedValueStrippable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public extension Array where Element: AssociatedValueStrippable {
    func filter(stripped: [Element.Stripped]) -> [Element] {
        var filtered = [Element]()
        for attribute in self {
            guard stripped.contains(attribute.stripped) && !(filtered.map { $0.stripped }.contains(attribute.stripped)) else { continue }
            filtered.append(attribute)
        }
        return filtered
    }
}
