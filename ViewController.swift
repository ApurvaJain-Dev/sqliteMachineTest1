//
//  ViewController.swift
//  sqliteMachineTest1
//
//  Created by Student-001 on 25/09/19.
//  Copyright © 2019 apurva. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var foodName = [String]()
    var priceTag = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        
        
    }
    @IBOutlet weak var plusButton: UIBarButtonItem!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return foodName.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = foodName[indexPath.row]
        cell.detailTextLabel?.text = priceTag[indexPath.row]
        
        return cell
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let selectQuery = "select foodName, priceTag from foodMenu"
        databaseLibrary.sharedObj.selectAllTask(query: selectQuery)
        foodName = databaseLibrary.sharedObj.taskName
        priceTag = databaseLibrary.sharedObj.taskPrice
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func alertMessage() {
        
        let alert = UIAlertController(title: "Alert", message: "Please enter the food item and price", preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK", style: .default) { (OkAction) in
            print("Ok Pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(OkAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

}

 
