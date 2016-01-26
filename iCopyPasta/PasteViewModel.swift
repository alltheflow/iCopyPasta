//
//  PasteViewModel.swift
//  iCopyPasta
//
//  Created by Agnes Vasarhelyi on 05/01/16.
//  Copyright © 2016 Agnes Vasarhelyi. All rights reserved.
//

import Foundation
import RxSwift

typealias ObservableArray = Observable<Array<PasteboardItem>>

class PasteViewModel {

    func pasteboardItems() -> ObservableArray {
        return PasteboardService.pasteboardService.pasteboardItems.asObservable()
    }

    func addItemsToPasteboard(pasteboardItem: PasteboardItem) {
        var item: Dictionary<String, AnyObject>
        switch pasteboardItem {
        case .Text(let string):
            item = ["NSString" : NSString(string: string)]
        case .Image(let image):
            item = ["UIImage" : image]
        case .URL(let url):
            item = ["NSURL" : url]
        }
        return PasteboardService.pasteboardService.addItemsToPasteboard([item])
    }

}
