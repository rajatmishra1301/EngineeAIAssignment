//
//  ViewController.swift
//  EngineerAIAssignment
//
//  Created by Grave Walker on 12/28/19.
//  Copyright © 2019 Rajat Mishra. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var postsTableView: UITableView!
    //@IBOutlet weak var _: _!
    //@IBOutlet weak var _: _!
    
    //MARK: - Properties
    
    
    //MARK: - Controls
    
    
    
    //MARK: - Main View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Other Methods
    
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.PostsTableCell, for: indexPath) as! PostTableViewCell
    }
    
}
