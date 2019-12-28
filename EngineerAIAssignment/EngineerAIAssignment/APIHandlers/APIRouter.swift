//
//  APIRouter.swift
//  EngineerAIAssignment
//
//  Created by Grave Walker on 12/28/19.
//  Copyright © 2019 Rajat Mishra. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getPosts(page: Int)
    
    var method: HTTPMethod {
        switch self {
            case .getPosts: return .get
        }
    }
    
    var path: String {
        switch self {
            case .getPosts: return "search_by_date"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPosts(let page):
            return [ParametersKey.tags: "story", ParametersKey.page: page]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkingSetup.appState.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
    
}
