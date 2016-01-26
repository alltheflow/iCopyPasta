//
//  PasteboardService.swift
//  iCopyPasta
//
//  Created by Agnes Vasarhelyi on 05/01/16.
//  Copyright © 2016 Agnes Vasarhelyi. All rights reserved.
//

import UIKit
import RxSwift

typealias PasteboardItemArray = Array<Dictionary<String, AnyObject>>

private var service = PasteboardService()

class PasteboardService {

    let pasteboardItems = Variable(Array<PasteboardItem>())
    let changeCount = Variable(0)

    let disposeBag = DisposeBag()

    init() {
        let pasteboard = UIPasteboard.generalPasteboard()
        
        let observableString = pasteboard.rx_observe(String.self, "string")
        let observableImage = pasteboard.rx_observe(UIImage.self, "image")
        
        observableString.subscribeNext { [weak self] string in
            if let item = string {
                self?.addItem(item)
            }
        }.addDisposableTo(disposeBag)
        
        observableImage.subscribeNext { [weak self] image in
            if let item = image {
                self?.addItem(item)
            }
        }.addDisposableTo(disposeBag)
    }

    class var pasteboardService: PasteboardService {
        return service
    }

    func pollPasteboardItems() {
        let pasteboard = UIPasteboard.generalPasteboard()

        if changeCount.value == pasteboard.changeCount {
            return
        }

        if let pasteboardString = pasteboard.string {
            addItem(pasteboardString)
        }

        if let pasteboardImage = pasteboard.image {
           addItem(pasteboardImage)
        }
    }

    func addItemsToPasteboard(items: PasteboardItemArray) {
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.addItems(items)
    }

    func addItem(item: AnyObject) {
        let pasteboardItem = self.pasteboardItem(item)!
        pasteboardItems.value = pasteboardItems.value.filter { pasteboardItem != $0 }
        pasteboardItems.value.append(pasteboardItem)

        let pasteboard = UIPasteboard.generalPasteboard()
        changeCount.value = pasteboard.changeCount
    }

    // MARK: prvivate functions

    private func pasteboardItem(item: AnyObject?) -> PasteboardItem? {
        if let string = item as? String {
            return .Text(string)
        }

        if let image = item as? UIImage {
            return .Image(image)
        }

        if let url = item as? NSURL {
            return .URL(url)
        }

        fatalError("unsupported types")
    }

}
