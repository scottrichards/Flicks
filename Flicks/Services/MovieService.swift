//
//  MovieService.swift
//  Flicks
//
//  Created by Scott Richards on 10/10/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
    
    func loadNowPlaying(error : ((NSError) -> ())? = nil,
                  success : ((JSON) -> ())? = nil
        )
    {
        
//        var headers: [String: String]?
//        var parameters: [String: String]?
        
        let apiEndPoint = URLs.NowPlaying + "?" + Params.api_key + "=" + MovieService.APIKey

        Alamofire.request(apiEndPoint).responseJSON {
            response in
            
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            if let jsonData = response.data {
                let json = JSON(data: jsonData)
                print("json: \(json)")
                if let success = success {
                    success(json)
                }
            }
        }

        
    }

}
