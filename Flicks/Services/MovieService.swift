//
//  MovieService.swift
//  Flicks
//
//  Created by Scott Richards on 10/10/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import Alamofire
import JASON

class MovieService: NSObject {
    static let APIKey = "55935c499e7ace3a866b7ca1847f462e"
    struct URLs {
        static let Endpoint = "https://api.themoviedb.org/3/movie"
        static let Search = Endpoint + "/search"
        static let NowPlaying = Endpoint + "/now_playing"
    }
    struct Params {
        static let api_key = "api_key"
    }
    
    func loadNowPlaying(failure : ((NSError) -> ())? = nil,
                  success : (() -> ())? = nil
        )
    {
        
        var headers: [String: String]?
        var parameters: [String: String]?
        
        let apiEndPoint = URLs.NowPlaying + "?" + Params.api_key + "=" + MovieService.APIKey
//        Alamofire.request().responseJASON {
//            response in
//            
//            
//        }
        Alamofire.request(apiEndPoint).responseJSON {
            response in
            
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }

        
        //Alamofire.request(apiEndPoint, method: .get, parameters: parameters, encoding: <#T##ParameterEncoding#>, headers: HTTPHeaders?)
//        Alamofire.request(.GET, apiEndPoint, headers: headers, parameters: parameters).validate().responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let jsonData = response.data {
//                    //                    self.json = JSON(data: data)
//                    //                    print("json: \(self.json)")
//                    if let succeed = success {
//                        succeed(response)
//                    }
//                }
//            case .Failure(let error):
//                print(error)
//                if let fail = failure {
//                    fail(error)
//                }
//            }
//        }
    }

}
