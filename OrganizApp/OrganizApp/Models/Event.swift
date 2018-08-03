//
//  Event.swift
//  OrganizApp
//
//  Created by Memo on 8/2/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Event {
    
    // Properties
    
//    var dictValue: [String: Any] {
//
//    }
    
    // Properties
    
    let uid: String
    
    var title: String = ""
    var location: String = ""
    var dateAndTime: String = ""
    var url: String = ""
    var notes: String = ""
    
    
    // init Methods
    
    init(uid: String, title: String, location: String, dateAndTime: String, url: String, notes: String) {
        self.uid = uid
        self.title = title
        self.dateAndTime = dateAndTime
        self.url = url
        self.notes = notes
    }
    
    // Init by aquiring event from database
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let title = dict["title"] as? String,
            let location = dict["location"] as? String,
            let dateAndTime = dict["date"] as? String,
            let url = dict["url"] as? String,
            let notes = dict["notes"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.title = "Event: " + title
        self.location = "Location: " + location
        self.dateAndTime = dateAndTime
        
        if url != "" {
            self.url = "url: " + url
        } else {
            self.url = url
        }
        
        if notes != "" {
            self.notes = "Notes: " + notes
        } else {
            self.notes = notes
        }
        
    }
    
    
}



