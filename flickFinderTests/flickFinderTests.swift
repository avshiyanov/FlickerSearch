//
//  flickFinderTests.swift
//  flickFinderTests
//
//  Created by Mrudul Pendharkar on 08/11/15.
//  Copyright © 2015 SimpleSoln. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import flickFinder

class flickFinderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFlickPhotoModel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let photo = FlickrPhoto(json: JSON(["id":"123", "url_m" : "http://images.csmonitor.com/csmarchives/2011/12/ADOODLE.jpg"]))
        XCTAssertEqual(photo?.photoId, "123")
        XCTAssertEqual(photo?.imageUrl, "http://images.csmonitor.com/csmarchives/2011/12/ADOODLE.jpg")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
