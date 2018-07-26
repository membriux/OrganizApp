//
//  UpcomingEventsViewController.swift
//  OrganizApp
//
//  Created by Memo on 7/24/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit

class UpcomingEventsViewController: UIViewController {
    
    
    // Outlets
    @IBOutlet weak var aboutButton: UIBarButtonItem!
    @IBOutlet weak var eventsTable: UITableView!
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func aboutButtonTapped(_ sender: UIBarButtonItem) {
        // Show about page
    }
    
    
}

