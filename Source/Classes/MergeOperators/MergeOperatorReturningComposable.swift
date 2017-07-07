//
// MergeOperatorReturningComposable.swift
// ViewComposer
//
// Created by Alexander Cyon on 2017-06-04.
//
//

import Foundation

////////////////////////////////////////////////
//MARK: -
//MARK: -
//MARK: LHS: `Attributed`
//MARK: -
//MARK: -
////////////////////////////////////////////////

//MARK: RHS `Attributed`
// RHS MASTER
public func <<- <E: ExpressibleByAttributes, C: Composable>(lhs: E, rhs: E) -> C where C.Style == E {
    return C(lhs <<- rhs)
}

// RHS SLAVE
public func <- <E: ExpressibleByAttributes, C: Composable>(lhs: E, rhs: E) -> C where C.Style == E {
    return C(lhs <- rhs)
}

//MARK: RHS `[Attributed.Attribute]`
// RHS MASTER
public func <<- <E: ExpressibleByAttributes, C: Composable>(lhs: E, rhs: [E.Attribute]) -> C where C.Style == E {
    return C(lhs <<- rhs)
}

// RHS SLAVE
public func <- <E: ExpressibleByAttributes, C: Composable>(lhs: E, rhs: [E.Attribute]) -> C where C.Style == E {
    return C(lhs <- rhs)
}

//MARK: RHS `Attributed.Attribute`
// RHS MASTER
public func <<- <E: ExpressibleByAttributes, C: Composable>(lhs: E, rhs: E.Attribute) -> C where C.Style == E {
    return C(lhs <<- rhs)
}

// RHS SLAVE
public func <- <E: ExpressibleByAttributes, C: Composable>(lhs: E, rhs: E.Attribute) -> C where C.Style == E {
    return C(lhs <- rhs)
}

////////////////////////////////////////////////
//MARK: -
//MARK: -
//MARK: LHS: `[Attributed.Attribute]`
//MARK: -
//MARK: -
////////////////////////////////////////////////

//MARK: RHS `Attributed`
// RHS MASTER
public func <<- <E: ExpressibleByAttributes, C: Composable>(lhs: [E.Attribute], rhs: E) -> C where C.Style == E {
    return C(lhs <<- rhs)
}

// RHS SLAVE
public func <- <E: ExpressibleByAttributes, C: Composable>(lhs: [E.Attribute], rhs: E) -> C where C.Style == E {
    return C(lhs <- rhs)
}

////////////////////////////////////////////////
//MARK: -
//MARK: -
//MARK: LHS: `Attributed.Attribute`
//MARK: -
//MARK: -
////////////////////////////////////////////////

//MARK: RHS `Attributed`
// RHS MASTER
public func <<- <E: ExpressibleByAttributes, C: Composable>(lhs: E.Attribute, rhs: E) -> C where C.Style == E {
    return C([lhs] <<- rhs)
}

// RHS SLAVE
public func <- <E: ExpressibleByAttributes, C: Composable>(lhs: E.Attribute, rhs: E) -> C where C.Style == E {
    return C([lhs] <- rhs)
}
