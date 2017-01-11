//
//  FilterViewController.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2017-01-04.
//  Copyright © 2017 Tomza. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift


class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    //MARK: Properties
    var filters = [Filter]()
    var ageGroupOptions = [String]()
    var typeOptions = [String]()
    var pickerData = [String]()
    
    
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ageGroupOptions = ["Early Child",
                    "Child",
                    "Youth",
                    "Child & Youth",
                    "Adult",
                    "Older Adult"]
        
        typeOptions = ["Hockey & Shinny",
                     "Leisure Skating",
                     "Womens Shinny"]
        
        let ageGroupFilter = Filter(name: "Age Group", options: ageGroupOptions, selectedOption: "")
        
        let typeFilter = Filter(name: "Type", options: typeOptions, selectedOption: "")
        
        filters.append(ageGroupFilter)
        filters.append(typeFilter)
        
        
        filterView.isHidden = true
    }   
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pickerData = filters[indexPath.row].options
        pickerView.reloadAllComponents()

        filterView.isHidden = false
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FilterTableViewCell
//        
//        var filterNames = [String]()
//        for filter in filters.keys {
//            filterNames.append(filter)
//        }
        
        cell.filterName.text = filters[indexPath.row].name
        cell.selectionLabel.text = filters[indexPath.row].selectedOption
        return cell
    }
    
    
    //picker view datasource methods
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
        
    }
    
    
    //pickerview delgate methods
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerData[row]
    }
    
    @IBAction func searchFilter(_ sender: Any) {
        filters[(filterTableView.indexPathForSelectedRow?.row)!].selectedOption = pickerData[pickerView.selectedRow(inComponent: 0)]
        
        filterView.isHidden = true
        filterTableView.reloadData()
    }
    
}

