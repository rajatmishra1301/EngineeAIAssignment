//
//  APIClient.swift
//  EngineerAIAssignment
//
//  Created by Grave Walker on 12/28/19.
//  Copyright © 2019 Rajat Mishra. All rights reserved.
//

import Foundation
import Alamofire

struct APIClient {
    
    static private func performDataRequest<T: Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping ((Result<T, AFError>)->Void)) {
        print(route.urlRequest!)
        AF.request(route).responseDecodable { (dataResponse: DataResponse<T, AFError>) in
            completion(dataResponse.result)
        }
    }
    
    static func getPosts(forPage page: Int, completion: @escaping ((Result<CoreResponseData, AFError>)->Void)) {
        performDataRequest(route: APIRouter.getPosts(page: page), completion: completion)
    }
    
}
