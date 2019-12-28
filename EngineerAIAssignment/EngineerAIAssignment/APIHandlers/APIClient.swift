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

    static func handleFailure(for error: AFError) -> String {
        var message = ""
        if let err = error.underlyingError as NSError? {
            if err.code == NSURLErrorNetworkConnectionLost {
                message = "Internet connection lost. Please connect to internet and try again."
            } else if err.code == NSURLErrorTimedOut {
                message = "Request timed out. Please try again after sometime."
            } else if err.code == NSURLErrorNotConnectedToInternet {
                message = "You're not connected to internet. Please connect to internet and try again."
            }
        } else {
            message = "Something went wrong. Please try again after sometime."
        }
        return message
    }
    
}
