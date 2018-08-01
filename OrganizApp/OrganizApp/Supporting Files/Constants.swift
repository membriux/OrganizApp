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
    
    static var orgsDict = defaults.dictionary(forKey: "organizationsDict") ?? [:]
    static var orgsArray = defaults.stringArray(forKey: "organizationsArray") ?? []
    
}

struct Home {
    
    static var currentOrgId =  ""
    static var currentOrgName = ""
    
}











