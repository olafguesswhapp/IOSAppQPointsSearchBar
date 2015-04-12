//
//  ViewController.swift
//  QPointsApp
//
//  Created by Olaf Peters on 11.04.15.
//  Copyright (c) 2015 GuessWhapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    
    var myLoyaltyPrograms:[String] = []
    var filteredLoyaltyPrograms:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        
        self.myLoyaltyPrograms = ["Ice-issima", "Your Hair Points", "Healthy & Loyal"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.active {
            return self.filteredLoyaltyPrograms.count
        }
        else {
            return self.myLoyaltyPrograms.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        var foodName : String
        if self.searchController.active {
            foodName = filteredLoyaltyPrograms[indexPath.row]
        }
        else {
            foodName = myLoyaltyPrograms[indexPath.row]
        }
        cell.textLabel?.text = foodName
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    // Mark - UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = self.searchController.searchBar.text
        let selectedScopeButtonIndex = self.searchController.searchBar.selectedScopeButtonIndex
        self.filterContentForSearch(searchString, scope: selectedScopeButtonIndex)
        self.tableView.reloadData()
    }
    func filterContentForSearch (searchText: String, scope: Int) {
        self.filteredLoyaltyPrograms = self.myLoyaltyPrograms.filter({ (program : String) -> Bool in
            var programMatch = program.rangeOfString(searchText)
            return programMatch != nil
        })
    }


}

