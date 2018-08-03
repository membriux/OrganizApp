//
//  UpcomingEventsViewController.swift
//  OrganizApp
//
//  Created by Memo on 7/24/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit

class UpcomingEventsViewController: UIViewController {
    
    // Properties
    
    var events = [Event]()
    var eventDate: [String: [String]] = [:]
    
    // Outlets
    @IBOutlet weak var aboutButton: UIBarButtonItem!
    @IBOutlet weak var eventsTable: UITableView!
    @IBOutlet weak var nagivationBarTitle: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
    }
    
    
    @IBAction func aboutButtonTapped(_ sender: UIBarButtonItem) {
        // Show about page
    }
    
    
    func configureViewController() {
        if UD.currentOrg != "" {
            // change title
            self.nagivationBarTitle.title = UD.currentOrg
            getEvents()
            
        }
    }
    
    func getEvents() {
        OrganizationService.show(forUID: UD.currentOrgId) { (organization) in
            guard let organization = organization else { return }
            EventService.events(for: organization) { (events) in
                let upcomingEvents = DateHelper.filtered(events: events)
                self.events = DateHelper.sorted(events: upcomingEvents)
                self.eventsTable.reloadData()
                
                // Get the date string from event object and add them in a dictionary
                for event in events {
                    let date = DateHelper.splitDateString(date: event.dateAndTime)
                    self.eventDate[event.title] = date
                }
                
            }
        }
    }
    
    
}


extension UpcomingEventsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingEventsTableCell", for: indexPath) as! UpcomingEventsTableCell
        
        cell.eventMonthLabel.text = eventDate[events[indexPath.row].title]?[1]
        cell.eventDayLabel.text = eventDate[events[indexPath.row].title]?[2]
        cell.eventTimeLabel.text = eventDate[events[indexPath.row].title]?[4..<6].reduce("@") { $0 + " " + $1}
        cell.eventTitleLabel.text = events[indexPath.row].title
        cell.eventLocationLabel.text = events[indexPath.row].location
        cell.eventNotesLabel.text = events[indexPath.row].notes
        
        
        
        return cell
    }
}




