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
    associatedtype Generic

    func create(newRecord: Generic) throws
    func read() throws -> [Generic]
    func update(updatedRecord: Generic) throws

}

struct CanvasImage: Equatable {
    let data: Data
    let identifier: String
}
