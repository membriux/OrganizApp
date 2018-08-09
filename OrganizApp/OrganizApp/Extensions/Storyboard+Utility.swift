//
//  Storyboard+Utility.swift
//  OrganizApp
//
//  Created by Memo on 7/25/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum OGType: String {
        case home
        case admin

        
        var filename: String {
            return rawValue.capitalized
        }
    }
}

extension UIStoryboard {
    // ...
    
    convenience init(type: OGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: OGType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}
