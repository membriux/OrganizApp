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
        errorLabel.text = ""
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        finished()
    }
    
    
    @IBAction func addOrganization(_ sender: UIButton) {
        guard let targetOrg = inputTextField.text,
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
        
        
    }
    
    func finished() {
        let initialViewController: UIViewController
        initialViewController = UIStoryboard.initialViewController(for: .home)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    
    
    
    
    
    
    
    
    
    
}
















