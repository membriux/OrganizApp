//
//  AboutPageViewController.swift
//  OrganizApp
//
//  Created by Memo on 8/6/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AboutPageViewController: UIViewController {
    
    let org = UD.currentOrgId
    
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var organizationEmailLabel: UILabel!
    @IBOutlet weak var organizationStreetLabel: UILabel!
    @IBOutlet weak var organizationCityLabel: UILabel!
    @IBOutlet weak var organizationStateLabel: UILabel!
    @IBOutlet weak var organizationZipLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
    }
    
    func configureLabels() {
        OrganizationService.show(forUID: org) { (org) in
            if let org = org {
                self.organizationNameLabel.text = org.organizationUsername
                self.organizationEmailLabel.text = org.email
                self.organizationStreetLabel.text = org.street
                self.organizationStateLabel.text = org.state
                self.organizationZipLabel.text = org.zip
            }
        }
    }
    
    
    
    
}
