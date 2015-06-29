//
//  ColorTableViewController.swift
//  NextNewApp
//
//  Created by Пользователь on 16.06.15.
//  Copyright (c) 2015 mpei. All rights reserved.
//

import UIKit
import CoreData

protocol ColorTablePalette:NSObjectProtocol {
    func addColor(color: UIColor, withName name: String)
    func editColor(newColor: UIColor, withName name:String)
    func existingColor(name: String) -> Bool
    func cancel()
}

class ColorTableViewController: UITableViewController, ColorTablePalette {

    var colors = NNColor.fetchColors()
    var selectedCell: ColorTableViewCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //mangedDuplicatesForColors = colorResults.1
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addColor(color: UIColor, withName name: String) {
        if colors.filter({$0.name == name}).first == nil {
            colors.append( NNColor( name: name, color: color))
            tableView.reloadData()
            CoreDataHelper.save()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // cancel color add or edit
    func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // checks if color exists
    func existingColor(name: String) -> Bool {
        return colors.filter({$0.name == name}).first != nil
    }
    
    func editColor(newColor: UIColor, withName name: String) {
        if let color = selectedCell?.namedColor {
            color.color = newColor
            color.name = name
            tableView.reloadData()
            CoreDataHelper.save()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        super.prepareForSegue(segue, sender: sender)
        if let ColorView = segue!.destinationViewController as? ViewController {
            ColorView.delegate = self
            
            if segue.identifier == "addColor" {
                ColorView.mode = .Add
            } else {
                ColorView.mode = .Edit
                ColorView.editedColor = selectedCell?.namedColor
            }
            
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return colors.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ColorTableViewCell", forIndexPath: indexPath) as! ColorTableViewCell
        //
        cell.namedColor = colors[indexPath.row]
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.beginUpdates()

        
        if editingStyle == .Delete {
            // Delete the row from the data source

            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ColorTableViewCell
            
            colors.removeAtIndex(indexPath.item)
            CoreDataHelper.instance.context.deleteObject(cell.namedColor!)
            CoreDataHelper.save()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        tableView.endUpdates()
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCell = tableView.cellForRowAtIndexPath(indexPath) as? ColorTableViewCell
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


}
