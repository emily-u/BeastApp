//
//  toBeastTableViewController.swift
//  redoBeast
//
//  Created by Emily on 1/30/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit
import CoreData

class toBeastTableViewController: UITableViewController, ViewControllerDelegate, cellDelegate {

    var tasks = [Task]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchAllItems(){
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            let results = try managedObjectContext.fetch(itemRequest)
            tasks = results as! [Task]
//            for item in tasks {
//                print("\(item.coolTextAttribute)")
//            }
        } catch {
            print("\(error)")
        }
        if tasks.count > 0{
            tasks = tasks.filter{$0.completed == false}
        }
        
    }

    func savelist(by controller: addViewController, title: String, completed: Bool, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            let item = tasks[ip.row]
            item.title = title
            item.completed = false
        }
        
        else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managedObjectContext) as! Task
            item.title = title
            item.completed = false
            tasks.append(item)
        }
     
        do{
            try managedObjectContext.save()
        }
        catch{
            print("\(error)")
        }
        dismiss(animated: true, completion: nil)
        fetchAllItems()
        tableView.reloadData()
    }
    
    func beastCell(_ sender: CustomCell) {
        let indexPath = tableView.indexPath(for: sender)! as NSIndexPath
        let item = tasks[indexPath.row]
        item.completed = true
        do{
            try managedObjectContext.save()
            print(item)
        }catch{
            print(error)
        }
        tasks.remove(at: indexPath.row)
        tableView.reloadData()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addItemSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        fetchAllItems()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! CustomCell
        cell.showTitle?.text = tasks[indexPath.row].title
        cell.delegate = self

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! addViewController
        controller.delegate = self
        
        if ((sender as? IndexPath) != nil) {
            let ip = sender as! NSIndexPath
            controller.indexPath = ip
            controller.titleField = tasks[ip.row].title
        }
    }

    //********************************************   delete   ***************************************************
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var item : Task?
        item = tasks[indexPath.row]
        tasks.remove(at: indexPath.row)
        managedObjectContext.delete(item!)
        
        do {
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    //********************************************   edit   ***************************************************
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addItemSegue", sender: indexPath)
    }

}

