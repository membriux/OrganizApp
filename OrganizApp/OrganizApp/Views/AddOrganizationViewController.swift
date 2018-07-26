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
    }
    
    
    
}


extension AddOrganizationViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        guard let user = authDataResult?.user
            else { return }
        
        AdminService.show(forUID: user.uid) { (admin) in
            if let admin = admin {
                // handle existing user
                Admin.setCurrent(admin)
                
                let initialViewController = UIStoryboard.initialViewController(for: .admin)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
                
            } else {
                // handle new user
                self.performSegue(withIdentifier: Segue.toCreateAdminUsername, sender: self)
            }
        }
        
    }
    
    
    
    
    
    

}


