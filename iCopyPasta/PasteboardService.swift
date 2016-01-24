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
    let pasteboardItems = Variable(Array<String>())
    let changeCount = Variable(0)

    @objc func pollPasteboardItems() {

        if changeCount.value == pasteboard.changeCount {
            return
        }

        guard let pasteboardItem = pasteboard.string else {
            return
        }
        
        pasteboardItems.value.append(pasteboardItem)
        pasteboardItems.value = pasteboardItems.value.reverse()
        changeCount.value = pasteboard.changeCount

    }

}
