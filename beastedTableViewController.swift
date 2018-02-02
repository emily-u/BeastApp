//
//  beastedTableViewController.swift
//  redoBeast
//
//  Created by Emily on 1/30/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit
import CoreData

class beastedTableViewController: UITableViewController {
    
    var tasks = [Task]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        fetchAllItems()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    func fetchAllItems(){
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            let results = try managedObjectContext.fetch(itemRequest)
            tasks = results as! [Task]
          
        } catch {
            print("\(error)")
        }
        if tasks.count > 0{
            tasks = tasks.filter{$0.completed == true}
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completedcell", for: indexPath)
        let item = tasks[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM d"
        cell.detailTextLabel?.text = dateFormatter.string(from: date)
        return cell
        
    }
    
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

}
