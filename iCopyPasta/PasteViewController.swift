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
        
        let items = Observable.just([
                pasteViewModel.pasteboardService.pasteboard.string
            ])
        
        items
            .bindTo(tableView.rx_itemsWithCellIdentifier("pasteCell", cellType: UITableViewCell.self)) { (row, element, cell) in
                if let paste = element {
                    cell.textLabel?.text = "\(paste as String)"
                }
            }.addDisposableTo(disposeBag)
        
        
        tableView
            .rx_modelSelected(String)
            .subscribeNext { value in
                // item selected
            }.addDisposableTo(disposeBag)
    }
    
}

