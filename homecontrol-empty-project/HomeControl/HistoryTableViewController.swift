//
//  HistoryTableViewController.swift
//  HomeControl
//
//  Created by vntlab on 7/15/16.
//  Copyright © 2016 venturus. All rights reserved.
//

import UIKit
import Foundation

class HistoryTableViewController: UITableViewController{
    
    var tableViewHomeInfoArray = Array<HomeModel>()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewHomeInfoArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text="\(self.tableViewHomeInfoArray[indexPath.row].temperatureValue)"
        cell.detailTextLabel?.text=self.tableViewHomeInfoArray[indexPath.row].time
        return cell
    }
    
}