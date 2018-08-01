//
//  ViewController.swift
//  OrganizApp
//
//  Created by Memo on 7/24/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var posts = [Post]()

    @IBOutlet weak var aboutButton: UIBarButtonItem!
    @IBOutlet weak var postTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    func configureViewController() {
        if Home.currentOrgId != "" {
            // change title
            getPosts()
        }
    }
    
    func getPosts() {
        OrganizationService.show(forUID: Home.currentOrgId) { (organization) in
            guard let organization = organization else { return }
            PostService.posts(for: organization) { (posts) in
//                print("Obtaining posts from:", organization.organizationUsername, "with uid:", organization.uid)
                self.posts = posts
                self.postTable.reloadData()
            }
        }
    }
    
    
    @IBAction func aboutButtonTapped(_ sender: UIBarButtonItem) {
        // Show about page
    }
    
  

    
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableCell", for: indexPath) as! PostsTableCell
        
        let post = posts[indexPath.row]
        
        cell.postSubjectLabel.text = post.subject
        cell.postDateLabel.text = post.creationDate
        cell.postTextLabel.text = post.content
        
        return cell
    }
}


