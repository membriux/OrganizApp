//
//  ViewController.swift
//  OrganizApp
//
//  Created by Memo on 7/24/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var aboutButton: UIBarButtonItem!
    @IBOutlet weak var postTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    @IBAction func aboutButtonTapped(_ sender: UIBarButtonItem) {
        // Show about page
    }
    

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableCell", for: indexPath) as! PostsTableCell
        
        cell.postSubjectLabel.text = "Post Subject"
        cell.postDateLabel.text = "July 26, 2018"
        cell.postTextLabel.text = "Prepare for this to be finished soon. I hope that this subject line passes on to the next and doesn't mess up with the size of the table cell."
        
        return cell
    }
}


