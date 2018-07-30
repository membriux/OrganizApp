//
//  Organization.swift
//  OrganizApp
//
//  Created by Memo on 7/26/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot
import Foundation


class Organization: Codable {
    
    // Singleton
    
//    private static var _current: Organization?
//    
//    
//    static var current: Organization {
//        
//        guard let currentOrg = _current else {
//            fatalError("Error: current org doesn't exist")
//        }
//        
//        
//        return currentOrg
//    }
//    
//    // Save organization to UserDefaults
//    static func setCurrent(_ organization: Organization, writeToUserDefaults: Bool = false) {
//        if writeToUserDefaults {
//            if let data = try? JSONEncoder().encode(organization) {
//                UserDefaults.standard.set(data, forKey: Defaults.currentOrg)
//            }
//        }
//    }

    
    
    // Properties
    
    let uid: String
    let organizationUsername: String
    
    var email: String = ""
    var calendarEmail: String = ""
    var street: String = ""
    var city: String = ""
    var state: String = ""
    var zip: String = ""
    
    
    // init Methods
    
    init(uid: String, organizationUsername: String) {
        self.uid = uid
        self.organizationUsername = organizationUsername
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let organizationUsername = dict["organizationUsername"] as? String,
            let email = dict["email"] as? String,
            let calendarEmail = dict["calendarEmail"] as? String,
            let street = dict["street"] as? String,
            let city = dict["city"] as? String,
            let state = dict["state"] as? String,
            let zip = dict["zip"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.organizationUsername = organizationUsername
        self.email = email
        self.calendarEmail = calendarEmail
        self.street = street
        self.city = city
        self.state = state
        self.zip = zip
        
    }
    
}









