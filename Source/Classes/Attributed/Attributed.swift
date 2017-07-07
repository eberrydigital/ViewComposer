//
//  Attributed.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-05-31.
//
//

import Foundation

/// Type that holds a collection of attributes used to style some `Styleable`. 
/// This collection can be merged with another instance of it sharing the same `Attribute` associatedtype.
/// You can also extract values associated to a certain attribute e.g. the `UIColor` associated to the attribute `backgroundColor`.
public protocol Attributed: ExpressibleByAttributes, Collection {
    
    /// Needed for conformance to `Collection`
    var startIndex: Int { get }
    
    //MARK: - Collection associatedtypes
    associatedtype Index = Int
    associatedtype Iterator = IndexingIterator<Self>
    associatedtype Indices = DefaultIndices<Self>
}
