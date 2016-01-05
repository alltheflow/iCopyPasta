//
//  PasteboardItem.swift
//  iCopyPasta
//
//  Created by Agnes Vasarhelyi on 05/01/16.
//  Copyright © 2016 Agnes Vasarhelyi. All rights reserved.
//

import UIKit

func ==(lhs: PasteboardItem, rhs: PasteboardItem) -> Bool {
    switch (lhs, rhs) {
    case (.Text(let str1), .Text(let str2)): return str1 == str2
    case (.Image(let img1), .Image(let img2)): return img1.isEqual(img2)
    case (.URL(let str1), .URL(let str2)): return str1 == str2
    default: return false
    }
}

func !=(lhs: PasteboardItem, rhs: PasteboardItem) -> Bool {
    return !(lhs == rhs)
}

enum PasteboardItem {
    case Text(String)
    case URL(NSURL)
    case Image(UIImage)
}
