//
//  PasteViewModel.swift
//  iCopyPasta
//
//  Created by Agnes Vasarhelyi on 05/01/16.
//  Copyright © 2016 Agnes Vasarhelyi. All rights reserved.
//

import RxSwift

typealias ObservableArray = Observable<Array<AnyObject>>

class PasteViewModel {

    let pasteboardService = PasteboardService()
    
    func pasteboardItems() -> ObservableArray {
        return pasteboardService.pasteboardItems.asObservable()
    }

    func pollPasteboardItems() {
        pasteboardService.pollPasteboardItems()
    }

}
