//
//  DuplicatesHandlerManager.swift
//  ViewComposer
//
//  Created by Alexander Cyon on 2017-07-07.
//

import Foundation

public final class DuplicatesHandlerManager: DuplicatesHandler {
    public static let shared = DuplicatesHandlerManager()
    var handlers: [AnyDuplicatesHandler] = []
}

