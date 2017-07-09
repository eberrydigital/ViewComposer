//
//  MergeOperatorReturningAttributed.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-06-04.
//
//

import Foundation

////////////////////////////////////////////////
//MARK: -
//MARK: LHS: `Attributed`
//MARK: -
////////////////////////////////////////////////

//MARK: RHS `Attributed`
// RHS MASTER
public func <<- <E: Attributed>(lhs: E, rhs: E) -> E {
    return lhs.merge(overwrittenBy: rhs)
}

public func <<- <E: Attributed>(lhs: E?, rhs: E) -> E {
    return lhs.merge(overwrittenBy: rhs)
}

public func <<- <E: Attributed>(lhs: E, rhs: E?) -> E {
    return rhs.merge(superiorTo: lhs)
}

// RHS SLAVE
public func <- <E: Attributed>(lhs: E, rhs: E) -> E {
    return lhs.merge(superiorTo: rhs)
}

public func <- <E: Attributed>(lhs: E?, rhs: E) -> E {
    return lhs.merge(superiorTo: rhs)
}

public func <- <E: Attributed>(lhs: E, rhs: E?) -> E {
    return rhs.merge(overwrittenBy: lhs)
}

//MARK: RHS `[Attributed.Attribute]`
// RHS MASTER
public func <<- <E: Attributed>(lhs: E, rhs: [E.Attribute]) -> E {
    return lhs.merge(overwrittenBy: rhs)
}

// RHS SLAVE
public func <- <E: Attributed>(lhs: E, rhs: [E.Attribute]) -> E {
    return lhs.merge(superiorTo: rhs)
}

//MARK: RHS `Attributed.Attribute`
// RHS MASTER
public func <<- <E: Attributed>(lhs: E, rhs: E.Attribute) -> E {
    return lhs.merge(overwrittenBy: [rhs])
}

// RHS SLAVE
public func <- <E: Attributed>(lhs: E, rhs: E.Attribute) -> E {
    return lhs.merge(superiorTo: [rhs])
}

////////////////////////////////////////////////
//MARK: -
//MARK: LHS: `[Attributed.Attribute]`
//MARK: -
////////////////////////////////////////////////

//MARK: RHS `Attributed`
// RHS MASTER
public func <<- <E: Attributed>(lhs: [E.Attribute], rhs: E) -> E {
    return lhs.merge(overwrittenBy: rhs)
}

// RHS SLAVE
public func <- <E: Attributed>(lhs: [E.Attribute], rhs: E) -> E {
    return lhs.merge(superiorTo: rhs)
}

//////////////////////////////////////////////////////////
//MARK: -
//MARK: LHS: `Attributed.Attribute`
//MARK: -
//////////////////////////////////////////////////////////

//MARK: RHS `Attributed`
// RHS MASTER
public func <<- <E: Attributed>(lhs: E.Attribute, rhs: E) -> E {
    return rhs.merge(superiorTo: lhs)
}

// RHS SLAVE
public func <- <E: Attributed>(lhs: E.Attribute, rhs: E) -> E {
    return rhs.merge(overwrittenBy: lhs)
}
