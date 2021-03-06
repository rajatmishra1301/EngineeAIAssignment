//
//  PostTableViewCell.swift
//  EngineerAIAssignment
//
//  Created by Grave Walker on 12/28/19.
//  Copyright © 2019 Rajat Mishra. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var selectPostSwitch: UISwitch!
    
    //MARK: - Properties
    var post: Post? {
        didSet {
            guard let postDetail = post else { return }
            textLabel?.text = postDetail.title
            detailTextLabel?.text = (postDetail.created_at ?? "").convertToDisplayDate()
            selectPostSwitch.setOn(postDetail.isSelected, animated: true)
        }
    }
    
    
}
