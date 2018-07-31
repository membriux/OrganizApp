//
//  OrganizationService.swift
//  OrganizApp
//
//  Created by Memo on 7/26/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct OrganizationService {

    
    static func find(targetOrg: String, completion: @escaping ([Organization]) -> Void) {

        
        let ref = Database.database().reference().child("organizations")
        
        // Returns all the organizations from the database
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            
            // Searches the organization that the user wants to add
            let organizationMatch = snapshot.compactMap(Organization.init).filter { $0.organizationUsername.lowercased() == targetOrg.lowercased() }
        
            completion(organizationMatch)
            
        })
    }
    
    
    
//    // Returns the organization that the admin is modifying
//    static func organizations(for admin: Admin, completion: @escaping (Organization?) -> Void) {
//        let ref = Database.database().reference().child("organizations").child(uid)
//
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
//                return completion([])
//            }
//
//            let posts = snapshot.reversed().compactMap(Post.init)
//            completion(posts)
//        })
//    }
    
    
    static func show(forUID uid: String, completion: @escaping (Organization?) -> Void) {
        let ref = Database.database().reference().child("organizations").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let organization = Organization(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(organization)
        })
    }
    
    // Create organization and save it to the database
    static func create(organizationUsername: String, email: String, calendarEmail: String, street: String, city: String, state: String, zip: String, completion: @escaping (Organization?) -> Void) {
        
        // Create dict to store adminUsernames
        
        let organizationAttrs = ["organizationUsername": organizationUsername,
                                 "email": email,
                                 "calendarEmail": calendarEmail,
                                 "street": street,
                                 "city": city,
                                 "state": state,
                                 "zip": zip
                                ]
        
        // Specify path of the database and create unique id
        let organizationRef = Database.database().reference().child("organizations").childByAutoId()
        
        // Write data to database
        organizationRef.setValue(organizationAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // Read what the admin just wrote and create a snapshot of the admin
            organizationRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let organization = Organization(snapshot: snapshot)
                completion(organization)
            })
        }
    }
    
    
    
}


