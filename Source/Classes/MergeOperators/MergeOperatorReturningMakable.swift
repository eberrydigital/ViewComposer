//
//  MergeOperatorReturningMakable.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-06-05.
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
public func <<- <E: ExpressibleByAttributes, M: Makeable>(lhs: E, rhs: E) -> M where M.Style == E, M.Styled == M {
    return M.make(lhs <<- rhs)
}

// RHS SLAVE
public func <- <E: ExpressibleByAttributes, M: Makeable>(lhs: E, rhs: E) -> M where M.Style == E, M.Styled == M {
    return M.make(lhs <- rhs)
}

//MARK: RHS `[Attributed.Attribute]`
// RHS MASTER
public func <<- <E: ExpressibleByAttributes, M: Makeable>(lhs: E, rhs: [E.Attribute]) -> M where M.Style == E, M.Styled == M {
    return M.make(lhs <<- rhs)
}

// RHS SLAVE
public func <- <E: ExpressibleByAttributes, M: Makeable>(lhs: E, rhs: [E.Attribute]) -> M where M.Style == E, M.Styled == M {
    return M.make(lhs <- rhs)
}

//MARK: RHS `Attributed.Attribute`
// RHS MASTER
public func <<- <E: ExpressibleByAttributes, M: Makeable>(lhs: E, rhs: E.Attribute) -> M where M.Style == E, M.Styled == M {
    return M.make(lhs <<- rhs)
}

// RHS SLAVE
public func <- <E: ExpressibleByAttributes, M: Makeable>(lhs: E, rhs: E.Attribute) -> M where M.Style == E, M.Styled == M {
    return M.make(lhs <- rhs)
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
public func <<- <E: ExpressibleByAttributes, M: Makeable>(lhs: [E.Attribute], rhs: E) -> M where M.Style == E, M.Styled == M {
    return M.make(lhs <<- rhs)
}

// RHS SLAVE
public func <- <E: ExpressibleByAttributes, M: Makeable>(lhs: [E.Attribute], rhs: E) -> M where M.Style == E, M.Styled == M {
    return M.make(lhs <- rhs)
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
public func <<- <E: ExpressibleByAttributes, M: Makeable>(lhs: E.Attribute, rhs: E) -> M where M.Style == E, M.Styled == M {
    return M.make([lhs] <<- rhs)
}

// RHS SLAVE
public func <- <E: ExpressibleByAttributes, M: Makeable>(lhs: E.Attribute, rhs: E) -> M where M.Style == E, M.Styled == M {
    return M.make([lhs] <- rhs)
}
