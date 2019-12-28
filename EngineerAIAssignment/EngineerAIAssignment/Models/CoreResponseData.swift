//
//  CoreResponseData.swift
//  EngineerAIAssignment
//
//  Created by Grave Walker on 12/28/19.
//  Copyright © 2019 Rajat Mishra. All rights reserved.
//

import Foundation

struct CoreResponseData: Codable {
    
    let posts : [Post]?
    let page: Int?
    let hitsPerPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case posts = "hits"
        case page = "page"
        case hitsPerPage = "hitsPerPage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        posts = try values.decodeIfPresent([Post].self, forKey: .posts)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        hitsPerPage = try values.decodeIfPresent(Int.self, forKey: .hitsPerPage)
    }
    
}
