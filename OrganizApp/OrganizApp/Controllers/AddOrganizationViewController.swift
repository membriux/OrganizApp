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
    
    var orgs = UD.orgs
    
    
    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var addInputTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var notFoundErrorLabel: UILabel!
    @IBOutlet weak var organizationsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    
    
    @IBAction func adminButtonTapped(_ sender: Any) {
        configureViewController(for: self.view.window)
    }
    
    
    // Adds organization to the userdefaults so that it can preload the organizations
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        guard let targetOrg = addInputTextField.text,
        !targetOrg.isEmpty else { return }
        
        // Add organization to userDefault array if found
        OrganizationService.find(targetOrg: targetOrg) { (organization) in
            if organization.count != 0 {
                Organization.save(organization[0].organizationUsername)
                print("Saved:", organization[0].organizationUsername)
                self.orgs = UD.orgs
                
            } else {
                self.showError(org: targetOrg)
            }
            
        }
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
    
    func showError(org: String) {
        let error = "\(org) not found. Check Spelling!"
        self.notFoundErrorLabel.text = error
    }
    
    func configureViewController() {
        self.notFoundErrorLabel.text = ""
    }

}

// Manage table view cells
extension AddOrganizationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationsTableCell", for: indexPath) as! OrganizationsTableCell
    
        cell.organizationNameLabel.text = orgs[indexPath.row]
        
        return cell
    }
    
}


// Firebase Authentication
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




