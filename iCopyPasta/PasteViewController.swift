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
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        pasteViewModel.pasteboardItems()
            .bindTo(tableView.rx_itemsWithCellIdentifier("pasteCell", cellType: UITableViewCell.self)) { (row, element, cell) in
                switch element {
                case .Text(let string):
                    cell.textLabel?.text = String(string)
                case .Image(let image):
                    cell.imageView?.image = image
                case .URL(let url):
                    cell.textLabel?.text = String(url)
                }
        }.addDisposableTo(disposeBag)
        
        pasteViewModel.pasteboardItems()
            .subscribeNext { [weak self] _ in
                self?.tableView.reloadData()
            }.addDisposableTo(disposeBag)
        
        tableView
            .rx_modelSelected(PasteboardItem)
            .subscribeNext { [weak self] element in
                self?.pasteViewModel.addItemsToPasteboard(element)
            }.addDisposableTo(disposeBag)
    }

}

