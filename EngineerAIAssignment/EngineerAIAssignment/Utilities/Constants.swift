//
//  Constants.swift
//  EngineerAIAssignment
//
//  Created by Grave Walker on 12/28/19.
//  Copyright © 2019 Rajat Mishra. All rights reserved.
//

import UIKit

typealias TableCellIdentifiers = StoryboardIdentifiers.TableViewCell

enum StoryboardIdentifiers {
    
    enum TableViewCell {
        static let PostsTableCell = "PostsTableCell"
    }
}

class Constants {
    
    static func showAlert(withMessage message: String, on vc: UIViewController) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}
