//
//  AdminUser.swift
//  OrganizApp
//
//  Created by Memo on 7/24/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot
import Foundation

class Admin: Codable {
    
    // Singleton
    
    private static var _current: Admin?
    
    static var current: Admin {

        guard let currentAdmin = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        return currentAdmin
    }
    
    // Class methods
    
    // Save user to UserDefaults so they don't have to login again
    static func setCurrent(_ admin: Admin, writeToUserDefaults: Bool = false) {
    
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(admin) {
                UserDefaults.standard.set(data, forKey: Defaults.currentAdmin)
            }
        }
        _current = admin
    }

    // Properties
    
    let uid: String
    let adminUsername: String
    
    var managingOrg: String = ""
    var managingOrgID: String = ""
    
    
    // init Methods
    
    init(uid: String, username: String, organization: Organization) {
        self.uid = uid
        self.adminUsername = username
    }
    
    // Inits by aquiring admin user from the database
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.adminUsername = username
    }
    
}
