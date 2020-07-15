//
//  CoreDataArt4AllTests.swift
//  CoreDataArt4AllTests
//
//  Created by Pedro Henrique Guedes Silveira on 14/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import XCTest
@testable import Art4All

class CoreDataArt4AllTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testCoreDataObjectCreationAndFetch() throws {

        let testIdentifier = "SavedItem"
        let controller = CanvasImageCoreDataController()
        let savedObject = CanvasImage(data: Data(), identifier: testIdentifier)

        var savedObjects: [CanvasImage] = []
        do {
            try controller.create(newRecord: savedObject)
            savedObjects.append(contentsOf: try controller.read())
        } catch {
            XCTestError(_nsError: NSError())
        }

        XCTAssertEqual(savedObjects[0], savedObject)
    }

    func testCoreDataObjectUpdate() throws {

        let testData = "TestData"
        let newData = "NewData"
        let testURl = Data(base64Encoded: testData) ?? Data()
        let newURL = Data(base64Encoded: newData) ?? Data()

        let controller = CanvasImageCoreDataController()

        let savedObject = CanvasImage(data: testURl, identifier: testData)
            
        var fetchedRecords: [CanvasImage] = []
        
        do {
            try controller.create(newRecord: savedObject)
            let updatedRecord = CanvasImage(data: newURL, identifier: testData)
            try controller.update(updatedRecord: updatedRecord)
            
            try fetchedRecords.append(contentsOf: controller.read())
            
            XCTAssertEqual(fetchedRecords[1], updatedRecord)
        } catch {
            XCTestError(_nsError: NSError())
        }
    }

}
