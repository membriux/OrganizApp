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
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func aboutButtonTapped(_ sender: UIBarButtonItem) {
        // Show about page
    }
    
    
}


extension UpcomingEventsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingEventsTableCell", for: indexPath) as! UpcomingEventsTableCell
        
//        cell.eventMonthLabel.text = "July"
//        cell.eventDayLabel.text = "30"
//        cell.eventTitleLabel.text = "BBQ with the Bois"
//        cell.eventTimeLabel.text = "@ 6:00PM"
//        cell.eventLocationLabel.text = "Lake Chabot"
//        cell.eventDescriptionLabel.text = "Don't forget the date!"
        
        
        
        return cell
    }
}
