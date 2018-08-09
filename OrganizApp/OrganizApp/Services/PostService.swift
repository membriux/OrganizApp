//
//  PostService.swift
//  OrganizApp
//
//  Created by Memo on 7/30/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct PostService {
    
        // UpdatePost function under construction
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
    
    // Show posts of an organization
    static func posts(for organization: Organization, completion: @escaping ([Post]) -> Void) {
        
        let ref = Database.database().reference().child("posts").child(organization.uid)

        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }

            let posts = snapshot.reversed().compactMap(Post.init)

            completion(posts)
        })
        
        
    }
    
    
    static func create(subject: String, content: String, orgUid: String, completion: @escaping (Post?) -> Void) {
        
        let date = DateHelper.getDate()
        
        let postAttrs = ["subject": subject,
                         "content": content,
                         "creationDate": date]
        
        
        // Specify path of the database
        let postRef = Database.database().reference().child("posts").child(orgUid).childByAutoId()

        // Write post to database
        postRef.setValue(postAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // Read what was written and create a snapshot of the posts
            postRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let post = Post(snapshot: snapshot)
                completion(post)
            })
            
        }
    }
    
    
}


