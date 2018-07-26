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
    
    
    static func show(forUID uid: String, completion: @escaping (Admin?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let admin = Admin(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(admin)
        })
    }
    
    
    static func create(_ firUser: User, adminUsername: String, completion: @escaping (Admin?) -> Void) {
        let userAttrs = ["username": adminUsername]
        
        let ref = Database.database().reference().child("admins").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let admin = Admin(snapshot: snapshot)
                completion(admin)
            })
        }
    }
    
    
}

