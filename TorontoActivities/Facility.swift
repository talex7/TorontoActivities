//
//  Facility.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2016-12-15.
//  Copyright © 2016 Hamza Lakhani. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class Facility: Object, Mappable  {
    
    //Realm syntax
    dynamic var accessibility = ""
    dynamic var address = ""
    dynamic var latitude = 0.00
    dynamic var longitude = 0.00
    dynamic var locationID = ""
    dynamic var name = ""
    dynamic var phone = ""
    dynamic var postalCode = ""
    dynamic var district = ""
    
    
    
    var courses = List<Course>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        accessibility <- map["Accessible"]
        address <- map["Address"]
        courses <- (map["Courses"], RealmListTransform<Course>())
        
        locationID <- map["LocationID"]
        
    }
    
}
