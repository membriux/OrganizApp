//
//  AdminViewController.swift
//  OrganizApp
//
//  Created by Memo on 7/24/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {
    
    let admin = Admin.current
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var adminTitleLabel: UINavigationItem!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postContent: UITextView!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var createOrganizationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
    }
    
    // Create post
    @IBAction func postButtonTapped(_ sender: UIButton) {
        guard let subject = subjectTextField.text,
            let content = postContent.text,
        !subject.isEmpty && !content.isEmpty else { return }
        PostService.create(subject: subject, content: content, orgUid: admin.managingOrgId ) { (post) in
            guard let _ = post else {
                print("Oops, something went wrong")
                return
            }
            
            self.postSuccess()
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
    
    func configureViewController() {
        self.adminTitleLabel.title = "Welcome back " + admin.adminUsername + "!"
        if admin.managingOrg != "" {
            createOrganizationButton.isHidden = true
            self.organizationNameLabel.text = "Organization: " + admin.managingOrg
        } else {
            createEventButton.isHidden = true
        }
    }
    
    
    func postSuccess() {
        self.subjectTextField.text = ""
        self.postContent.text = ""
        self.postButton.backgroundColor = UIColor.lightGray
        self.postButton.setTitle("Done!", for: .normal)
    }
    
}
