//
//  PasteboardServiceTests.swift
//  iCopyPasta
//
//  Created by Vásárhelyi Ágnes on 26/01/16.
//  Copyright © 2016 Agnes Vasarhelyi. All rights reserved.
//

import XCTest
import RxSwift
@testable import iCopyPasta

class PasteboardServiceTests: XCTestCase {
    
    func testAddItem() {
        let pasteboardService = PasteboardService.pasteboardService
        pasteboardService.addPasteboardItem(.Text("pasta"))
        XCTAssertTrue(pasteboardService.pasteboardItems.value[0] == .Text("pasta"), "it should add new items")
    }

    func testAddItemsToPasteboard() {
        let pasteboardService = PasteboardService.pasteboardService
        pasteboardService.addItemsToPasteboard([["NSString":"pasta"]])
        XCTAssertTrue(pasteboardService.pasteboardItems.value[0] == .Text("pasta"), "it should add new items")
    }

}
