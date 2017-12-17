//
//  RestaurantTableViewController.swift
//  Foodie, an app for food enthusiats
//  Foodie allows enthusiats to share and favorite their favorite
//  restaurants
//
//  Created by Janelle Heron on 12/17/17.
//  Copyright © 2017 Janelle Heron. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    //An array of Restaurant Names
    var restaurantNames = [
        "Cafe Deadend", "Homei", "Teakha", "Cafe Loisl",
        "Petite Oyster", "For Kee Restaurant", "Po's Atelier",
        "Bourke Street Bakery", "Haigh's Chocolate", "Traif",
        "Palomino Espresso", "Upstate", "Cafe Lore",
        "Waffle & Wolf", "Five Leaves", "Confessional",
        "Barrafina", "Donostia", "Royal Oak",
        "CASK Pub and Kitchen", "Graham Avenue Meats"
    ]

    //An array of Restaurant Images
    var restaurantImages = [
        "cafedeadend.jpg", "homei.jpg", "teakha.jpg",
        "cafeloisl.jpg", "petiteoyster.jpg", "posatelier.jpg",
        "bourkestreetbakery.jpg", "forkeerestaurant.jpg",
        "haighschocolate.jpg", "palominoespresso.jpg",
        "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg",
        "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg",
        "confessional.jpg", "barrafina.jpg", "royaloak.jpg",
        "donostia.jpg", "caskpubkitchen.jpg"
    ]

    //An array of Restaurant Locations
    var restaurantLocations = [
        "Toronto", "Toronto", "Toronto", "San Francisco",
        "Califonia", "California", "California", "San Diego",
        "Sydney", "New York", "New York", "New York",
        "New York", "New York", "New York", "New York",
        "London", "London", "London", "London", "Sydney"
    ]
    
    //An array of restaurant Types
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American",
        "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee  & Tea",
        "Latin American", "Spanish", "Spanish", "Spanish", "British",
        "Thai"]
    
      var restaurantIsVisited = Array(repeating: false, count: 21)
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restaurantNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:
            indexPath) as! RestaurantTableViewCell
        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        
        //Creates an accessory, checkmark, sets it as an optional
        //User visitation to the restaurant
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Add Call action
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
            
        }
        
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        // Check-in action
        // Determine the check in title. If the selected restaurant has been checked (i.e.
        // restaurantIsVisited[indexPath.row] returns true), the title will be set to "Undo Check in".
        let checkInTitle = restaurantIsVisited[indexPath.row] ? "Undo Check in" : "Check in"
        let checkInAction = UIAlertAction(title: checkInTitle, style: .default, handler: {
            //update the value of the Bool array when a restaurant is checked
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            
            // Toggle check-in and undo-check-in (updates check-in), if restaurant visit cond. is met
            self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
        })
        optionMenu.addAction(checkInAction)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
    }
    
    //Provided by TableViewController, handles insertion and or deletion of data of a specific row,
    //even without functionality, the delete button will appear on swipe.
    override func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //If delete is selected then
        if editingStyle == .delete {
            restaurantNames.remove(at: indexPath.row)
            restaurantLocations.remove(at: indexPath.row)
            restaurantTypes.remove(at: indexPath.row)
            restaurantImages.remove(at: indexPath.row)
            restaurantIsVisited.remove(at: indexPath.row)
        }
            tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt
        indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style:
            UITableViewRowActionStyle.default, title: "Share", handler: { (action,
                indexPath) -> Void in
                let defaultText = "Just checking in at " +
                    self.restaurantNames[indexPath.row]
                let activityController = UIActivityViewController(activityItems:
                    [defaultText], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
        })
        //Delete button
        let deleteAction = UITableViewRowAction(style:  UITableViewRowActionStyle.default, title: "Delete",handler: { (action,
            indexPath) -> Void in
            // Delete the row from the data source
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            self.restaurantImages.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        //Torquise share button
        shareAction.backgroundColor = UIColor(red: 1/255.0, green: 173.0/255.0,
                                              blue: 200/254.0, alpha: 1.0)
        //Red delete button
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 0/0,
                                               blue: 0/0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
}
    
