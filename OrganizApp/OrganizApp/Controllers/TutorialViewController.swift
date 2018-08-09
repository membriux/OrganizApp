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
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        let initialViewController: UIViewController
        initialViewController = UIStoryboard.initialViewController(for: .home)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func addOrganization(_ sender: UIButton) {
        
        
        
    }
    
    
    
    
    
}
















