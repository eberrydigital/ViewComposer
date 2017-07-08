//
//  AttributesMerger.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public final class AttributesMerger: AttributesMergable {
    
    public static var shared = AttributesMerger()
    
    private var mergers: [AttributesMergable.Type] = [DefaultMerger.self]
    private static var mergers: [AttributesMergable.Type] {
        get { return shared.mergers }
        set { shared.mergers = newValue }
    }
    public func merge<E: ExpressibleByAttributes>(dominant: E, yielding: E) -> E {
        var merged: E = dominant
        mergers.forEach {
            merged = $0.merge(dominant: merged, yielding: yielding)
        }
        return merged
    }
    
    public static func merge<E: ExpressibleByAttributes>(dominant: E, yielding: E) -> E {
        return shared.merge(dominant: dominant, yielding: yielding)
    }
    
    internal func append(_ merger: AttributesMergable.Type) {
        mergers.insert(merger, at: 0)
    }
    
    public static func removeAllMergers() {
        shared.mergers.removeAll()
        shared.mergers.append(DefaultMerger.self)
    }
    
    public static func append(_ merger: AttributesMergable.Type) {
        shared.append(merger)
    }
}

public func append(_ merger: AttributesMergable.Type) {
    AttributesMerger.append(merger)
}

public func merge<E: ExpressibleByAttributes>(dominant: E, yielding: E) -> E {
    return AttributesMerger.merge(dominant: dominant, yielding: yielding)
}
