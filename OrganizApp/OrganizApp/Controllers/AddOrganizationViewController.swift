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
        configureViewController(for: self.view.window)
    }
    
    // Checks whether an admin is signed in. If not, they would log in
    func configureViewController(for window: UIWindow?) {

        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        authUI.delegate = self
        
        let defaults = UserDefaults.standard
        let initialViewController: UIViewController
        
        // Determine whether there is an admin logged in
        if let _ = Auth.auth().currentUser,
            let adminData = defaults.object(forKey: Defaults.currentAdmin) as? Data,
            let admin = try? JSONDecoder().decode(Admin.self, from: adminData) {
            
            Admin.setCurrent(admin, writeToUserDefaults: true)
            
            initialViewController = UIStoryboard.initialViewController(for: .admin)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
            
        } else {
            let authViewController = authUI.authViewController()
            present(authViewController, animated: true)
        }
        
    }
    
}


extension AddOrganizationViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        guard let user = authDataResult?.user
            else { return }
        
        AdminService.show(forUID: user.uid) { (admin) in
            if let admin = admin {
                // handle existing user
                Admin.setCurrent(admin, writeToUserDefaults: true)
                
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


