//
//  AddOrganizationViewController.swift
//  OrganizApp
//
//  Created by Memo on 7/24/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase


class AddOrganizationViewController: UIViewController {
    
    
    @IBOutlet weak var adminButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func adminButtonTapped(_ sender: Any) {
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
        
        performSegue(withIdentifier: "AdminView", sender: self)
    }
    
    
    
}


extension AddOrganizationViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let user = authDataResult?.user
            else { return }
        
        let userRef = Database.database().reference().child("users").child(user.uid)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let adminUser = AdminUser(snapshot: snapshot) {
                print("Welcome back, \(adminUser.username).")
            } else {
                self.performSegue(withIdentifier: "toCreateAdminUsername", sender: self)
            }

        })
    }
    
    
}



