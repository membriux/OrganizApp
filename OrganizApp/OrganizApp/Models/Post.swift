//
//  Post.swift
//  OrganizApp
//
//  Created by Memo on 7/30/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Post: Codable {
    
    // Properties
    
    var dictValue: [String : Any] {
        let date = creationDate
        
        return ["subject" : subject,
                "content" : content,
                "created_at" : date]
    }
    
    let uid: String
    let creationDate: String
    
    var subject: String = ""
    var content: String = ""
    
    
    // init Methods
    
    init(uid: String, subject: String, content: String, creationDate: String) {
        self.uid = uid
        self.creationDate = creationDate
        self.subject = subject
        self.content = content
    }
    
    // Inits by aquiring post from the database
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let creationDate = dict["creationDate"] as? String,
            let subject = dict["subject"] as? String,
            let content = dict["content"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.creationDate = creationDate
        self.subject = subject
        self.content = content
    }
    
}
