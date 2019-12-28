//
//  NetworkingSetup.swift
//  EngineerAIAssignment
//
//  Created by Grave Walker on 12/28/19.
//  Copyright © 2019 Rajat Mishra. All rights reserved.
//

import Foundation

typealias ParametersKey = NetworkingSetup.ParametersKey

struct NetworkingSetup {
    
    static let appState: AppState = .development
    
    enum AppState {
        case stage
        case development
        
        var baseURL: String {
            switch self {
            case .stage: return ""
            case .development: return "https://hn.algolia.com/api/v1/"
            }
        }
    }
    
    enum ParametersKey {
        static let tags = "tags"
        static let page = "page"
    }
    
    
    
}
