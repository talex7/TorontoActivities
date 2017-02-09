//
//  SessionsViewController.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2017-01-04.
//  Copyright © 2017 Tomza. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import MapKit
import CoreLocation

class SessionsViewController: UITableViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    
    //MARK:Properties
    var locationManager = CLLocationManager()
    
    

    
    
    var fetchedSessions: [Session]!
    var fetchedCourses: Results<Course>! // added for test
    var sessionArray = List<Session>()
    
    @IBOutlet var sessionTableView: UITableView!
    @IBOutlet var sortBySwitch: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let searchManager = SearchManager2()
        //        searchManager.getJSON()
        
        //fetching all sessions from database
//        if fetchedSessions == nil {
//            let realm = try! Realm()
//            fetchedSessions = realm.objects(Session.self).filter("ANY course.category = 'Skating'")
//        }
        
        locationManager.delegate = self
        sessionTableView.reloadData()
        
//        //testing links
//        var i = 1
//        for session in fetchedSessions {
//            
//            print("\((session.course.first?.facility.count)!) -  \(i)")
//            i += 1
//        }
//        


        
    }
    func configureCell(cell: SessionViewCell, indexPath: IndexPath) {
        
        
        let date = fetchedSessions[indexPath.row].fullDate
        let course = fetchedSessions[indexPath.row].course.first
        let facility = course?.facility.first
//        
//        let facilityName = course?.facility.first?.name
        
        cell.sessionNameLabel.text = fetchedSessions[indexPath.row].date + " - \(fetchedSessions[indexPath.row].time)"
        
        cell.sessionTypeLabel.text = course?.programName
        cell.sessionAgeGroupLabel.text = course?.ageGroup
        
        
        if let label = cell.timeLabel {
            label.text = stringFromTimeInterval(interval: (date?.timeIntervalSinceNow)!)
        }
//        distance label
        if let label2 = cell.distanceLabel{
            label2.text = distanceBetween(facility: facility!)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedSessions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SessionViewCell

        configureCell(cell: cell, indexPath: indexPath)
        
        cell.facilitiesButton.tag = indexPath.row
        cell.facilitiesButton.addTarget(self, action: #selector(SessionsViewController.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    
    @IBAction func buttonTapped(_ sender:UIButton!){
        self.performSegue(withIdentifier: "facilitySegue", sender: sender)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "facilitySegue" {
            if let destination = segue.destination as? DetailedViewController {
                
                if let button:UIButton = sender as! UIButton? {
                    destination.selectedFacility = fetchedSessions[button.tag].course[0].facility[0]
                }
            }
        }
    }

    
//    @IBAction func sortSwitch(_ sender: Any) {
//        
//        if sortBySwitch.isEnabled{
//            fetchedSessions.sort() { $0.fullDate > $1.fruitName }
//        }
//    }
//    
    
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let time = Int(interval)
        
        let minutes = (String(format: "%02d", ((time / 60) % 60)))
        let hours = (time / 3600)
        let dateString = "\(hours):\(minutes) \nTime Left"
        
        return dateString
    }
    //Disatnce
    func distanceBetween(facility: Facility) -> String {
        
        
        self.locationManager.requestLocation()
//        let currentLat = self.locationManager.location!.coordinate.latitude
//        let currentLong = self.locationManager.location!.coordinate.longitude
        
//        self.locationManager.startUpdatingLocation()
        
//        let currentLocation = CLLocation(latitude: currentLat, longitude: currentLong)
        
        let currentLocation = self.locationManager.location!
        
        if let lat = facility.latitude, let long = facility.longitude {
            let facilityLocation = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
            let initialDistance = currentLocation.distance(from: facilityLocation) / 1000
            
            let distanceString = "\(initialDistance) km"
            return distanceString
            
        } else {
            
            let facilityLocation = CLLocation(latitude: 0, longitude: 0)
            let initialDistance = currentLocation.distance(from: facilityLocation) / 1000
            
            let distanceString = "\(initialDistance) km"
            
            
            
            return distanceString
        }

    }
    
    //CLLocation Delegate Methods
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    
    @IBAction func directionsTo(_ sender: Any) {
        openMapsAppWithDirections(to: <#T##CLLocationCoordinate2D#>, destinationName: <#T##String#>)
    }
    
    //apple maps feature
    func openMapsAppWithDirections(to coordinate: CLLocationCoordinate2D, destinationName name: String) {
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name // Provide the name of the destination in the To: field
        mapItem.openInMaps(launchOptions: options)
    }
    
}
