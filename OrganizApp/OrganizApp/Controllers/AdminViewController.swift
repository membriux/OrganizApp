//
//  AdminViewController.swift
//  OrganizApp
//
//  Created by Memo on 7/24/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit
import Firebase

class AdminViewController: UIViewController {
    
    let admin = Admin.current
    var time = 2
    var successTimer = Timer()
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var adminTitleLabel: UINavigationItem!
    @IBOutlet weak var addPostLabel: UILabel!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postContent: UITextView!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var createOrganizationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureKeyboard()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // .default
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        handleLogout()
    }
    
    // Create post
    @IBAction func postButtonTapped(_ sender: UIButton) {
        guard let subject = subjectTextField.text,
            let content = postContent.text,
        !subject.isEmpty && !content.isEmpty else { return }
        setLoadingStatus()
        
        PostService.create(subject: subject, content: content, orgUid: admin.managingOrgId ) { (post) in

            guard let _ = post else { return }
            
            self.successTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AdminViewController.postSuccess), userInfo: nil, repeats: true)
            
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func createOrganizationButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.toCreateOrganization, sender: self)
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        // Go Back to home menu
        let initialViewController: UIViewController
        initialViewController = UIStoryboard.initialViewController(for: .home)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    
    @IBAction func createEventButtonTapped(_ sender: UIButton) {
        // Updates email used for the calendar
        performSegue(withIdentifier: Segue.toCreateEvent, sender: self)
    }
    
    func configureKeyboard() {
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        
        let leadingFlex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        
        toolbar.setItems([leadingFlex, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        //setting toolbar as inputAccessoryView
        self.subjectTextField.inputAccessoryView = toolbar
        self.postContent.inputAccessoryView = toolbar
    }
    
    // Dismiss keyboard when "Done" pressed
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    
    func configureViewController() {
        
        self.adminTitleLabel.title = "Welcome, " + admin.adminUsername + "!"
        if admin.managingOrg != "" {
            createOrganizationButton.isHidden = true
            self.organizationNameLabel.text = "Organization: " + admin.managingOrg
        } else {
            createEventButton.removeFromSuperview()
            postButton.isHidden = true
            subjectTextField.isHidden = true
            postContent.isHidden = true
            addPostLabel.isHidden = true
            organizationNameLabel.text = "Lets get started by creating an organization!"
            organizationNameLabel.font = organizationNameLabel.font.withSize(32)
            
        }
    }
    
    
    func setLoadingStatus() {
        self.subjectTextField.text = ""
        self.postContent.text = ""
        self.postButton.setTitle("Loading...", for: .normal)
        self.postButton.backgroundColor = UIColor.lightGray
        
    }
    
    @objc func postSuccess() {
        // Reset textField
        
        
        // Decrementing the game timer by 1
        time -= 1
        if time == 0 {
            self.postButton.backgroundColor = Colors.darkBlue
            self.postButton.setTitle("Post", for: .normal)
            successTimer.invalidate()
            time = 2
        }
        else {
            self.postButton.backgroundColor = UIColor.lightGray
            self.postButton.setTitle("Done!", for: .normal)
        }
    }
    
    
    
    // Log out from the firebase and the admin page
    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
            Admin.setCurrent(nil, writeToUserDefaults: true)
            
            let initialViewController: UIViewController
            initialViewController = UIStoryboard.initialViewController(for: .home)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
            
            
        } catch let logoutError {
            print(logoutError)
        }
    }
    
}
