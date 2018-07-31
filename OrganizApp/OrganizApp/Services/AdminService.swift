//
//  AdminService.swift
//  OrganizApp
//
//  Created by Memo on 7/25/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct AdminService {
    
    
    static func update(forUID uid: String, organizationUID: String, organization: String, completion: @escaping (Admin?) -> Void) {
        let admin = Admin.current
        let ref = Database.database().reference().child("admins").child(uid)
        let newAdminAttrs = ["username": admin.adminUsername,
                             "managingOrganizationID": organizationUID,
                             "managingOrganization": organization]
        
        ref.setValue(newAdminAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
        }
        
    }
    
    static func show(forUID uid: String, completion: @escaping (Admin?) -> Void) {
        let ref = Database.database().reference().child("admins").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let admin = Admin(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(admin)
        })
    }
    
    
    static func create(_ firUser: User, adminUsername: String, completion: @escaping (Admin?) -> Void) {
        
        // Create dict to store adminUsernames
        let userAttrs = ["username": adminUsername]
        
        // Specify path of the database
        let ref = Database.database().reference().child("admins").child(firUser.uid)
        
        // Write data to database
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // Read what the admin just wrote and create a snapshot of the admin
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let admin = Admin(snapshot: snapshot)
                completion(admin)
            })
        }
    }
    
    
}

