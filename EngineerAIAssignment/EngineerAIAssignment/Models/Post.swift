//
//  Post.swift
//  EngineerAIAssignment
//
//  Created by Grave Walker on 12/28/19.
//  Copyright © 2019 Rajat Mishra. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    let created_at : String?
    let title : String?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {

        case created_at = "created_at"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
