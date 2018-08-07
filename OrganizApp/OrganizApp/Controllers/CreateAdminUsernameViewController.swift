
//
//  File.swift
//  OrganizApp
//
//  Created by Memo on 7/24/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateAdminUsernameViewController: UIViewController {
    
    @IBOutlet weak var adminUsernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // .default
    }
    
    
    // Create Admin User
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser,
            let username = adminUsernameTextField.text,
            !username.isEmpty else { return }
        
        // Create admin account
        AdminService.create(firUser, adminUsername: username) { (admin) in
            guard let admin = admin else {
                return
            }
            
            
            Admin.setCurrent(admin, writeToUserDefaults: true)
            print("Current user:", Admin.current)
            self.view.endEditing(true)
            
            // Go to admin page storyboard
            let initialViewController = UIStoryboard.initialViewController(for: .admin)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    
    }
    
    
    
}

