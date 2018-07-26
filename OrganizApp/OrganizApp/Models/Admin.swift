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

class Admin {
    
    // Singleton
    
    private static var _current: Admin?
    
    static var current: Admin {

        guard let currentAdmin = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        return currentAdmin
    }
    
    // Class methods
    
    static func setCurrent(_ admin: Admin) {
        _current = admin
    }
    
    
    // Properties
    
    let uid: String
    let adminUsername: String
    
    
    // init Methods
    
    init(uid: String, username: String) {
        self.uid = uid
        self.adminUsername = username
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.adminUsername = username
    }
    
}
