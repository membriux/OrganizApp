//
//  Constants.swift
//  OrganizApp
//
//  Created by Memo on 7/25/18.
//  Copyright © 2018 Membriux. All rights reserved.
//


import Foundation
import UIKit


struct Segue {
    
    static let toCreateAdminUsername = "toCreateAdminUsername"
    static let toCreateOrganization = "toCreateOrganization"
    static let toCreateEvent = "toCreateEvent"
    static let toViewAboutPage = "toViewAboutPage"
    
}

struct Cells {
    
    static let PostsTableViewCell = "PostsTableViewCell"
    static let UpcomingEventsTableViewCell = "UpcomingEventsTableViewCell"
    
}

struct Defaults {
    
    static let currentAdmin = "currentAdmin"
    static let currentOrg = "currentOrg"
    
}

struct UD {
    
    static let defaults = UserDefaults.standard
    static let organizationsArray = "organizationsArray"
    static let organizationsDict = "organizationsDict"
    
    static var currentOrg = defaults.string(forKey: "currentOrg") ?? ""
    static var currentOrgId = defaults.string(forKey: "currentOrgId") ?? ""
    
    static var orgsDict = defaults.dictionary(forKey: "organizationsDict") ?? [:]
    static var orgsArray = defaults.stringArray(forKey: "organizationsArray") ?? []
    
}

struct DateFormat {
    
    static let eventDateAndTime = "EEEE MMM d yyyy h:mm a"
    static let postDate = "MMM d, h:mm a"
    
}





