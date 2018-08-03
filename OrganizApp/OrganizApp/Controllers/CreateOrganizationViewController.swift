//
//  CreateOrganizationViewController.swift
//  OrganizApp
//
//  Created by Memo on 7/30/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateOrganizationViewController: UIViewController {
    
    @IBOutlet weak var orgUsernameTextField: UITextField!
    @IBOutlet weak var contactEmailTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func configureViewController() {
        errorLabel.text = ""
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        
        let leadingFlex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        
        toolbar.setItems([leadingFlex, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        //setting toolbar as inputAccessoryView
        self.orgUsernameTextField.inputAccessoryView = toolbar
        self.contactEmailTextField.inputAccessoryView = toolbar
        self.streetTextField.inputAccessoryView = toolbar
        self.cityTextField.inputAccessoryView = toolbar
        self.stateTextField.inputAccessoryView = toolbar
        self.zipTextField.inputAccessoryView = toolbar
        
    }
    
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //or
        //self.view.endEditing(true)
        return true
    }
    
    
    func updateCreateButton() {
        self.createButton.backgroundColor = UIColor.lightGray
        self.createButton.setTitle("Creating...", for: .normal)
    }
    
    
    func show(error: String) {
        self.errorLabel.text = error
    }
    
    // Creates Organization
    @IBAction func createButtonTapped(_ sender: UIButton) {
        updateCreateButton()
        let error = "Fields cannot be empty"
        let admin = Admin.current
        guard let organizationUsername = orgUsernameTextField.text,
            let contactEmail = contactEmailTextField.text,
            let street = streetTextField.text,
            let city = cityTextField.text,
            let state = stateTextField.text,
            let zip = zipTextField.text,
            !organizationUsername.isEmpty && !contactEmail.isEmpty && !street.isEmpty && !city.isEmpty && !state.isEmpty && !zip.isEmpty else { show(error: error); return }
        
        
        OrganizationService.create(organizationUsername: organizationUsername, email: contactEmail, street: street, city: city, state: state, zip: zip ) { (organization) in
            guard let organization = organization else {
                return
            }
            
            // Update admin in from userDefaults
            admin.managingOrg = organizationUsername
            admin.managingOrgId = organization.uid
            Admin.setCurrent(admin, writeToUserDefaults: true)
            
            AdminService.update(forUID: admin.uid, organizationUID: organization.uid, organization: organizationUsername) { (admin) in
                guard let _ = admin else { return }
            }
            
            let initialViewController = UIStoryboard.initialViewController(for: .admin)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
            
        }
        
    }

    

    
    
}








