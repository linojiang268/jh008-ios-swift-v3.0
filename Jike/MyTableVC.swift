//
//  MyTableVC.swift
//  Gather4
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class MyTableVC: UITableViewController {
    
    var myDelegate:MyTableDelegate!
    
    init() {
        super.init(style: UITableViewStyle.Plain)
        
    }

    
    
    override func viewDidLoad() {
        self.refreshControl = UIRefreshControl(frame: CGRectMake(0, 0, UiUtils.getBaseWidth(), 60))
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return myDelegate.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDelegate.tableView(tableView, numberOfRowsInSection: section)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}