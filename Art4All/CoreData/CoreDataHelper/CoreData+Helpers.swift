//
//  CoreData+Helpers.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 09/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation

enum DAOError: Error {
    case invalidData(description: String)
    case internalError(description: String)
}

protocol GenericDAO {
    associatedtype T

    func create(newRecord: T) throws
    func read() throws -> [T]
    func update(updatedRecord: T) throws

}

struct CanvasImage: Equatable {
    let data: Data
    let identifier: String
}
