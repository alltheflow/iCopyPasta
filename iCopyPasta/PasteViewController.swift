//
//  PasteViewController.swift
//  iCopyPasta
//
//  Created by Agnes Vasarhelyi on 05/01/16.
//  Copyright © 2016 Agnes Vasarhelyi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PasteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let pasteViewModel = PasteViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self.pasteViewModel.pasteboardService, selector: "pollPasteboardItems", userInfo: nil, repeats: true)
        timer.fire()

        let items = pasteViewModel.pasteboardService.pasteboardItems.asObservable()
        items.bindTo(tableView.rx_itemsWithCellIdentifier("pasteCell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = "\(element as String)"
        }.addDisposableTo(disposeBag)
        
        items.subscribeNext { _ in self.tableView.reloadData() }.addDisposableTo(disposeBag)
        
        tableView
            .rx_modelSelected(String)
            .subscribeNext { value in
                // item selected
            }.addDisposableTo(disposeBag)
    }
    
}

