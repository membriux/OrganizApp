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
    

    // Save organization to UserDefaults
    static func save(_ organizationUsername: String,_ organizationUID: String) {
        // Modify user defaults' array and dict
        UD.orgsDict[organizationUsername] = organizationUID
        UD.orgsArray.append(organizationUsername)
        
        // Save changes made to user defaults
        UD.defaults.set(UD.orgsDict, forKey: UD.organizationsDict )
        UD.defaults.set(UD.orgsArray, forKey: UD.organizationsArray)
        
    }
    
    
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









