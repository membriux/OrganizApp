//
//  EventService.swift
//  OrganizApp
//
//  Created by Memo on 8/2/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct EventService {
    
        // UpdateEvent function under construction
    //    static func update(forUID uid: String, organizationUID: String, organization: String, completion: @escaping (Admin?) -> Void) {
    //        let admin = Admin.current
    //        let ref = Database.database().reference().child("admins").child(uid)
    //        let newAdminAttrs = ["username": admin.adminUsername,
    //                             "managingOrganizationID": organizationUID,
    //                             "managingOrganization": organization]
    //        ref.setValue(newAdminAttrs) { (error, ref) in
    //            if let error = error {
    //                assertionFailure(error.localizedDescription)
    //                return completion(nil)
    //            }
    //        }
    //
    //    }
    
    // Show events of an organization
    static func events(for organization: Organization, completion: @escaping ([Event]) -> Void) {
        let ref = Database.database().reference().child("events").child(organization.uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            
            let events = snapshot.reversed().compactMap(Event.init)
            
            completion(events)
        })
    }
    
    
    static func create(orgUid: String, title: String, location: String, dateAndTime: String, notes: String, url: String,  completion: @escaping (Event?) -> Void) {
        
        let eventAttrs = ["title": title,
                         "location": location,
                         "date": dateAndTime,
                         "url": url,
                         "notes": notes]
        
        
        // Specify path of the database
        let eventRef = Database.database().reference().child("events").child(orgUid).childByAutoId()
        
        // Write event to database
        eventRef.setValue(eventAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // Read what was written and create a snapshot of the posts
            eventRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let event = Event(snapshot: snapshot)
                completion(event)
            })
            
        }
    }
    
    
}



