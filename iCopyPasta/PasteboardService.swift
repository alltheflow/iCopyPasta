//
//  PasteboardService.swift
//  iCopyPasta
//
//  Created by Agnes Vasarhelyi on 05/01/16.
//  Copyright © 2016 Agnes Vasarhelyi. All rights reserved.
//

import UIKit
import RxSwift
import MobileCoreServices

typealias PasteboardItemArray = Array<Dictionary<String, AnyObject>>

private var service = PasteboardService()

class PasteboardService {

    let pasteboardItems = Variable(Array<PasteboardItem>())
    let changeCount = Variable(0)
    let disposeBag = DisposeBag()

    init() {
        let pasteboard = NSNotificationCenter.defaultCenter().rx_notification("UIPasteboardChangedNotification", object: nil)
        _ = pasteboard.map { [weak self] (notification: NSNotification) -> PasteboardItem? in
            if let pb = notification.object as? UIPasteboard {
                if let string = pb.valueForPasteboardType(kUTTypeUTF8PlainText as String) {
                    return self?.pasteboardItem(string)
                }
                if let image = pb.valueForPasteboardType(kUTTypeImage as String) {
                    return self?.pasteboardItem(image)
                } else {
                    return nil
                }
            }
            return nil
        }
        .subscribeNext { [weak self] pasteboardItem in
            if let item = pasteboardItem {
                self?.addPasteboardItem(item)
            }
        }
        .addDisposableTo(disposeBag)
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
    
    func addPasteboardItem(pasteboardItem: PasteboardItem) {
        pasteboardItems.value = pasteboardItems.value.filter { pasteboardItem != $0 }
        pasteboardItems.value.append(pasteboardItem)
        
        let pasteboard = UIPasteboard.generalPasteboard()
        changeCount.value = pasteboard.changeCount
    }

    func addItem(item: AnyObject) {
        let pasteboardItem = self.pasteboardItem(item)!
        self.addPasteboardItem(pasteboardItem)
    }

    // MARK: prvivate functions

    private func pasteboardItem(item: AnyObject?) -> PasteboardItem? {
        if let string = item as? String {
            return .Text(string)
        }

        if let image = item as? UIImage {
            return .Image(image)
        }

        fatalError("unsupported types")
    }

}
