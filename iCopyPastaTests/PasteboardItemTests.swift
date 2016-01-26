//
//  PasteboardItemTests.swift
//  iCopyPasta
//
//  Created by Vásárhelyi Ágnes on 26/01/16.
//  Copyright © 2016 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
@testable import iCopyPasta

class PasteboardItemTests: XCTestCase {
    
    func testTextItem() {
        let textItem = PasteboardItem.Text("copy")
        XCTAssert(textItem == .Text("copy"), "should handle equal operator")
        XCTAssert(textItem != .Text("copy pasta"), "should handle not equal operator")
    }
    
    func testImageItem() {
        let imageItem = PasteboardItem.Image(UIImage(named: "pasta.png")!)
        XCTAssert(imageItem == .Image(UIImage(named: "pasta.png")!), "should handle equal operator")
        XCTAssert(imageItem != .Image(UIImage(named: "copy_pasta.png")!), "should handle not equal operator")
    }
    
    func testURLItem() {
        let urlItem = PasteboardItem.URL(NSURL(string: "http://url.com")!)
        XCTAssert(urlItem == .URL(NSURL(string: "http://url.com")!), "should handle equal operator")
        XCTAssert(urlItem != .URL(NSURL(string: "http://url.co.uk")!), "should handle not equal operator")
    }
}
