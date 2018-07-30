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
        dateFormatter.dateFormat = "MMMM-dd-yyyy h:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}
