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
    var pasteboardItems = Variable(Array<String>())

    @objc func pollPasteboardItems() {
        guard let pasteboardItem = pasteboard.string else {
            return
        }
        
        pasteboardItems.value.append(pasteboardItem)
    }

}
