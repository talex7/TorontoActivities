////
////  MasterViewController.swift
////  TorontoActivities
////
////  Created by Tomza on 2016-12-15.
////  Copyright © 2016 Tomza. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate { //UISearchResultsUpdating, UISearchBarDelegate,
//    
//    @IBOutlet var tableView: UITableView!
//
//    // MARK: - Properties
//    var facilityArray = [Facilites]()
//    var filteredfac = [Facilites]()
//    var shouldShowSearchResults = false
//    let searchController = UISearchController(searchResultsController: nil)
//    var fetchedResultsController: NSFetchedResultsController!
//    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    
//    func initializeFetchedResultsController() {
//      
//        let request = NSFetchRequest(entityName: "Facility")
//        
//        let districtSort = NSSortDescriptor(key: "district", ascending: true)
//        let alphaSort = NSSortDescriptor(key: "name", ascending: true)
//        request.sortDescriptors = [districtSort, alphaSort]
//        
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.moc, sectionNameKeyPath: "district", cacheName: "rootCache")
//        fetchedResultsController.delegate = self
//        
//        do {
//            try fetchedResultsController.performFetch()
//        } catch {
//            fatalError("Failed to initialize FetchedResultsController: \(error)")
//        }
//    }
//    
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let searchManager = SearchManager()
//        searchManager.getJson()
//        
//        do {
//            try self.fetchedResultsController.performFetch()
//        } catch {
//            let fetchError = error as NSError
//            print("Unable to Perform Fetch Request")
//            print("\(fetchError), \(fetchError.localizedDescription)")
//        }
//        
//        self.tableView.reloadData()
//        
////        searchController.searchResultsUpdater = self
////        searchController.searchBar.delegate = self
////        definesPresentationContext = true
////        searchController.dimsBackgroundDuringPresentation = false
//
//        //setup of the filter scope
////        
////        searchController.searchBar.scopeButtonTitles = ["North", "South", "West", "East"]
////        self.tableView.tableHeaderView = searchController.searchBar
//
////        //configureSearchController()
////        
////        facilityArray = [
////            Facilites(location:"North", name:"Rink 1"),
////            Facilites(location:"North", name:"Rink 2"),
////            Facilites(location:"South", name:"Rink 3"),
////            Facilites(location:"South", name:"Rink 4"),
////            Facilites(location:"East", name:"Rink 5"),
////            Facilites(location:"East", name:"Rink 6"),
////            Facilites(location:"West", name:"Rink 7"),
////            Facilites(location:"west", name:"Rink 8"),
////        ]
////    }
//
//    
//    // MARK: NSFetchedResultsControllerDelegate
//    
//    func controllerWillChangeContent(controller: NSFetchedResultsController) {
//        self.tableView.beginUpdates()
//    }
//    
//    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            self.tableView.insertSections(IndexSet(index: sectionIndex), with: .fade)
//           // self.tableView.insertSections(<#T##sections: IndexSet##IndexSet#>, with: .fade)
//        case .delete:
//            self.tableView.deleteSections(IndexSet(index: sectionIndex), with: .fade)
//        case .move:
//            break
//        case .update:
//            break
//        }
//    }
//    
//    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: IndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            self.tableView.insertRows(at: [newIndexPath!], with: .fade)
//        case .delete:
//            self.tableView.deleteRows(at: [indexPath!], with: .fade)
//        case .update:
//            configureCell(cell: self.tableView.cellForRow(at: indexPath!)! as! TableViewCell, indexPath: indexPath!)
//        case .move:
//            self.tableView.moveRow(at: indexPath!, to: newIndexPath!)
//        }
//    }
//    
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        self.tableView.endUpdates()
//    }
//    
//        // MARK: - TableViewDataSoure Delegate
//        func numberOfSections(in tableView: UITableView) -> Int {
//            //return 1
//            return fetchedResultsController.sections!.count
//        }
//        
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            //        if shouldShowSearchResults {
//            //            return filteredfac.count
//            //        }
//            //        else {
//            //            return facilityArray.count
//            //        }
//            guard let sections = fetchedResultsController.sections else {
//                fatalError("No sections in fetchedResultsController")
//            }
//            let sectionInfo = sections[section]
//            return sectionInfo.numberOfObjects
//        }
//        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            //    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
//            
//            //    let facilityObject: Facilites
//            //
//            //    if shouldShowSearchResults {
//            //    facilityObject = filteredfac[indexPath.row]
//            //
//            //    }else{
//            //
//            //    facilityObject = facilityArray[indexPath.row]
//            //    }
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
//            // Set up the cell
//            configureCell(cell: cell, indexPath: indexPath)
//            return cell
//        }
//        
//        func configureCell(cell: TableViewCell, indexPath: IndexPath) {
//            guard let selectedObject = fetchedResultsController.objectAtIndexPath(indexPath) as? Facility else { fatalError("Unexpected Object in FetchedResultsController") }
//            // Populate cell from the NSManagedObject instance
//            cell.nameLabel!.text = selectedObject.name
//            cell.nameLocation!.txt = selectedObject.address
//        }
//    
//   //init a search controller
//   /*func configureSearchController() {
//        searchController.dimsBackgroundDuringPresentation = true
//        //searchController.searchBar.placeholder = "Search here..."
//        searchController.searchBar.sizeToFit()
//        definesPresentationContext = true
//
//    
//        searchController.searchBar.scopeButtonTitles = ["North"] //added location as scope
//        tableSearch.tableHeaderView = searchController.searchBar
//    
//    }
// */
//    //filtering for the search
////    func filterContentForSearchText(searchText: String, scope: String = "All") {
////        filteredfac = facilityArray.filter { faculty in
////            let locationMatch = (scope == "All") || (faculty.location == scope)
////
////            return locationMatch && faculty.name.lowercased().contains(searchText.lowercased())
////        }
////        
////        self.tableView.reloadData()
////    }
//    
//    //delegate and search updating functions
////    
////    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
////        shouldShowSearchResults = true
////        self.tableView.reloadData()
////    }
//// 
////    
////    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
////        shouldShowSearchResults = false
////        self.tableView.reloadData()
////    }
////    
////    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
////        if !shouldShowSearchResults {
////            shouldShowSearchResults = true
////            self.tableView.reloadData()
////        }
////        
////        searchController.searchBar.resignFirstResponder()
////    }
////    func updateSearchResults(for searchController: UISearchController){
////        let searchBar = searchController.searchBar
////        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
////        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
////    }
////    
////    
////    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
////        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
////
////    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//}
