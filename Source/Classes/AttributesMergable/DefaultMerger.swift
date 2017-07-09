//
//  DefaultMerger.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public struct DefaultMerger: AttributesMergable {
    public static func merge<E: Attributed>(dominant: E, yielding: E) -> E {
        let unionSet = Set(dominant.stripped).union(Set(yielding.stripped))
        let unionAttributes = (dominant.attributes + yielding.attributes).filter(stripped: Array(unionSet))
        return E.init(unionAttributes)
    }
}
