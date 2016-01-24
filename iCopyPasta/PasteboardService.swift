//
//  PasteboardService.swift
//  iCopyPasta
//
//  Created by Agnes Vasarhelyi on 05/01/16.
//  Copyright © 2016 Agnes Vasarhelyi. All rights reserved.
//

import UIKit
import RxSwift

class PasteboardService {
    
    let pasteboard = UIPasteboard.generalPasteboard()
    let pasteboardItems = Variable(Array<AnyObject>())
    let changeCount = Variable(0)

    @objc func pollPasteboardItems() {

        if changeCount.value == pasteboard.changeCount {
            return
        }

        if let pasteboardString = pasteboard.string {
            pasteboardItems.value.append(pasteboardString)
        }
        
        if let pasteboardImage = pasteboard.image {
            pasteboardItems.value.append(pasteboardImage)
        }

        pasteboardItems.value = pasteboardItems.value.reverse()
        changeCount.value = pasteboard.changeCount

    }

}
