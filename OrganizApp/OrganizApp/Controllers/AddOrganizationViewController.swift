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
    @IBOutlet weak var addInputTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var organizationsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTextFieldInputs()
        
    }
    
    
    @IBAction func adminButtonTapped(_ sender: Any) {
        configureViewController(for: self.view.window)
    }
    
    
    // Adds organization to the userdefaults so that it can preload the organizations
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        guard let targetOrg = addInputTextField.text,
            !targetOrg.isEmpty else {return}
        
        // Add organization to userDefault array if found
        OrganizationService.find(targetOrg: targetOrg) { (organization) in
            if organization.count != 0 {
                let org = organization[0].organizationUsername
                let orgId = organization[0].uid
                
                // Checks if organizaiton was saved before
                if UD.orgsDict[org] == nil {

                    // Save organization
                    Organization.save(org, orgId)
                    self.organizationsTable.reloadData()
                    self.showSuccess(org: org)
                    
                } else {
                  self.showAlreadyExists(org: org)
                }
                
            } else {
                self.showError(org: targetOrg)
            }
            self.doneButtonAction()
        }
    }
    
    func showSuccess(org: String) {
        let success = "\(org) added!"
        self.status.text = success
    }
    
    func showError(org: String) {
        let error = "\(org) not found. Check Spelling!"
        self.status.text = error
    }
    
    func showAlreadyExists(org: String) {
        let error = "\(org) already in your list"
        self.status.text = error
    }
    
    func resetInputTextField() {
        self.addInputTextField.text = ""
    }
    
    func configureViewController() {
        self.status.text = ""
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

// Manage table view cells
extension AddOrganizationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UD.orgsArray.count
    }
    
    // Cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationsTableCell", for: indexPath) as! OrganizationsTableCell
    
        cell.organizationNameLabel.text = UD.orgsArray[indexPath.row]
        
        return cell
    }
    
    // Display feed of the organization selected from the table view cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Go to home view and display feed of selected organization
        let org = UD.orgsArray[indexPath.row]
        guard let orgId = UD.orgsDict[org] as? String else { return }
        
        
        UD.currentOrgId = orgId
        UD.defaults.set(orgId, forKey: "currentOrgId")
        
        UD.currentOrg = org
        UD.defaults.set(org, forKey: "currentOrg")
        
        let initialViewController = UIStoryboard.initialViewController(for: .home)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
        
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

extension AddOrganizationViewController {
    
    func configureTextFieldInputs() {
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        
        let leadingFlex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        
        toolbar.setItems([leadingFlex, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        //setting toolbar as inputAccessoryView
        self.addInputTextField.inputAccessoryView = toolbar
        
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    
}




