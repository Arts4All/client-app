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

    typealias Generic = CanvasImage

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

        guard let canvasImage = NSManagedObject(entity: canvasImageEntity, insertInto: managedContext) as?
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
                throw DAOError.invalidData(
                    description: "Failed to cast fetch request result to an Array of CDCanvasImage")
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

    func search(record: CanvasImage) throws -> CDCanvasImage {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", record.identifier)

        var returnedCanvasImage: CDCanvasImage?

        do {

            let result = try managedContext.fetch(fetchRequest)

            guard let canvasImageData = result as? [CDCanvasImage] else {
                throw DAOError.invalidData(
                    description: "Failed to cast fetch request resultto an Array of CDCanvasImage")
            }

            for canvasImage in canvasImageData where canvasImage.identifier == record.identifier {
                returnedCanvasImage = canvasImage
            }

            guard let guardedCanvasImage = returnedCanvasImage else {
                throw DAOError.internalError(description: "Failed to find the object")
            }

            return guardedCanvasImage
        } catch {
            throw DAOError.internalError(description: "Problem during core  data fetch request")
        }
    }

    func update(updatedRecord: CanvasImage) throws {

        do {
            let images = try self.read()

            for image in images where image.identifier == updatedRecord.identifier {
                let cdRecord = try self.search(record: image)
                cdRecord.imageData = updatedRecord.data
                CoreDataManager.shared.saveContext()
            }
        } catch {
            throw DAOError.internalError(description: "Problem during core  data fetch request")
        }
    }

    func delete(deletedRecord: CanvasImage) throws {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", deletedRecord.identifier)

        do {

            let result = try managedContext.fetch(fetchRequest)

            guard !result.isEmpty,
                let deletedObject = result.first as? CDCanvasImage else {
                throw DAOError.invalidData(description: "Result array is empty")
            }

            managedContext.delete(deletedObject)

            try managedContext.save()
        } catch {
            throw DAOError.internalError(description: error.localizedDescription)
        }
    }

    func deleteAll() throws {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)

        do {
            let result = try managedContext.fetch(fetchRequest)

            guard let canvasImageData = result as? [CDCanvasImage] else {
                throw DAOError.invalidData(
                    description: "Failed to cast fetch request result to an Array of CDCanvasImage")
            }

            for canvasImage in canvasImageData {
                managedContext.delete(canvasImage)
            }

        } catch {
            throw DAOError.internalError(description: "Problem during core  data fetch request")
        }
    }
}
