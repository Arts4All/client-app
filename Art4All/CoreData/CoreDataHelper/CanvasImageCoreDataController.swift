//
//  CanvasImageCoreDataController.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 13/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.

import Foundation
import CoreData
import UIKit

final public class CanvasImageCoreDataController: GenericDAO {

    typealias T = CanvasImage

    let managedContext = CoreDataManager.shared.persistentContainer.viewContext

    private let entityName = "CDCanvasImage"

    public static let shared: CanvasImageCoreDataController = CanvasImageCoreDataController()

    public init() {

    }

    func create(newRecord: CanvasImage) throws {

        let savedItems = try read()

        for savedItem in savedItems where savedItem.identifier == newRecord.identifier {
            return
        }

        guard let canvasImageEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
            throw DAOError.internalError(description: "Failed to create NSEntityDescription Entity")
        }

        guard let canvasImage = NSManagedObject(entity: canvasImageEntity, insertInto: managedContext)as?
                CDCanvasImage else {
            throw DAOError.internalError(description: "Failed to create NSManagedObject")
        }

        canvasImage.imageData =  newRecord.data
        canvasImage.identifier = newRecord.identifier
        CoreDataManager.shared.saveContext()

    }

    func read() throws -> [CanvasImage] {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)

        do {
            let result = try managedContext.fetch(fetchRequest)

            guard let canvasImageData = result as? [CDCanvasImage] else {
                throw DAOError.invalidData(description: "Failed to cast fetch request result to an Array of CDPreset")
            }

            var canvasImages: [CanvasImage] = []

            for canvasData in canvasImageData {
                canvasImages.append(
                    CanvasImage(data: canvasData.imageData ?? Data(), identifier: canvasData.identifier ?? ""))
            }
            return canvasImages
        } catch {
            throw DAOError.internalError(description: "Problem during core  data fetch request")
        }
    }

    func update(updatedRecord: CanvasImage) throws {
        return
    }

}
