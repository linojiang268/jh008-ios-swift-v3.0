//
//  MyTableDelegate.swift
//  Gather4
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation

protocol MyTableDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
}