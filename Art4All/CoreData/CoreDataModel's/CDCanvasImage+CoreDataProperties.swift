//
//  CDCanvasImage+CoreDataProperties.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 13/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//
//

import Foundation
import CoreData

extension CDCanvasImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCanvasImage> {
        return NSFetchRequest<CDCanvasImage>(entityName: "CDCanvasImage")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var identifier: String?

}
