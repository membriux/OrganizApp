//
//  DateUtilitiy.swift
//  OrganizApp
//
//  Created by Memo on 7/30/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import Foundation


struct DateHelper {
    
    static func getDate() -> String {
        
        let date = Date.init()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        dateFormatter.dateFormat = DateFormat.postDate
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static func splitDateString(date: String) -> [String] {
        // ex: "Sunday Aug 5 2018 5:23 PM"
        let fullDateArray = date.components(separatedBy: " ")
        return fullDateArray
    }
    

    // Filter out events that have passed already and keep the new ones
    static func filtered(events: [Event]) -> [Event] {
        // input ex: "Sunday Aug 5 2018 5:23 PM"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.eventDateAndTime
        
        let currentDateAndTime = Date.init()
        
        let filteredEvents = events.filter { (event) in
            if let date = dateFormatter.date(from: event.dateAndTime) {
                return date > currentDateAndTime
            }
            return true
        }
    
        return filteredEvents
    }
    
    
    static func sorted(events: [Event]) -> [Event] {
        // input ex: "Sunday Aug 5 2018 5:23 PM"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.eventDateAndTime

        let sortedEvents = events.sorted(by: {(previousEvent, currentEvent) in
            if let previousDate = dateFormatter.date(from: previousEvent.dateAndTime),
                let currentDate = dateFormatter.date(from: currentEvent.dateAndTime) {
                return currentDate.compare(previousDate) == .orderedDescending
            }
            return true
        })
        
        return sortedEvents
    }
    

    
    
}
