//
//  TutorialViewController.swift
//  OrganizApp
//
//  Created by Memo on 8/8/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation
import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var addOrganizationButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldInputs()
        errorLabel.text = ""
    }
    
    // Calls the finished() function to take the user to the main page
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        finished()
    }
    
    
    @IBAction func addOrganization(_ sender: UIButton) {
        guard let targetOrg = inputTextField.text,
            !targetOrg.isEmpty else {return}
    
        setLoadingStatus()
        
        // Add organization to userDefault array if found
        OrganizationService.find(targetOrg: targetOrg) { (organization) in
            if organization.count != 0 {
                let org = organization[0].organizationUsername
                let orgId = organization[0].uid
                
                // Checks if organizaiton was saved before
                if UD.orgsDict[org] == nil {
                    
                    // Save organization
                    Organization.save(org, orgId)
                    UD.currentOrgId = orgId
                    UD.defaults.set(orgId, forKey: "currentOrgId")
                    
                    UD.currentOrg = org
                    UD.defaults.set(org, forKey: "currentOrg")
                    self.finished()
                }
                
            } else {
                self.showError(org: targetOrg)
            }
        }
    }
    
    func showError(org: String) {
        errorLabel.text = "\(org) not found. Check spelling."
        addOrganizationButton.setTitle("Add Organization", for: .normal)
        addOrganizationButton.backgroundColor = Colors.lightBlue
    }
    
    // Add "Done" button to keyboard with the action that dismisses the keyboard
    func configureTextFieldInputs() {
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let leadingFlex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        // Set button on the right side
        toolbar.setItems([leadingFlex, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        //setting toolbar as inputAccessoryView
        self.inputTextField.inputAccessoryView = toolbar

    }

    // Dismis the keyboard
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    func setLoadingStatus() {
        addOrganizationButton.setTitle("Loading...", for: .normal)
        addOrganizationButton.backgroundColor = UIColor.lightGray
    }
    
    // Switch to the HomeViewController page
    func finished() {
        let initialViewController: UIViewController
        initialViewController = UIStoryboard.initialViewController(for: .home)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
 
    
}
















