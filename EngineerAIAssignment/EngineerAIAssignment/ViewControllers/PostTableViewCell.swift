//
//  PostTableViewCell.swift
//  EngineerAIAssignment
//
//  Created by Grave Walker on 12/28/19.
//  Copyright © 2019 Rajat Mishra. All rights reserved.
//

import UIKit

protocol PostTableViewCellDelegate {
    func didTapOnSwitch(newValue: Bool, forPostIndex: Int?)
}

class PostTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var selectPostSwitch: UISwitch!
    
    //MARK: - Properties
    var postCellDelegate: PostTableViewCellDelegate?
    var index: Int?
    var post: Post? {
        didSet {
            guard let postDetail = post else { return }
            textLabel?.text = postDetail.title
            detailTextLabel?.text = postDetail.created_at
            selectPostSwitch.isOn = postDetail.isSelected
        }
    }
    
    //MARK: - Actions
    @IBAction func didTapOnSwitch(sender: UISwitch) {
        postCellDelegate?.didTapOnSwitch(newValue: sender.isOn, forPostIndex: index)
    }
    
}
