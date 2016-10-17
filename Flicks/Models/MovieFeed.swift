//
//  NowPlayingFeed.swift
//  Flicks
//
//  Created by Scott Richards on 10/11/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieFeed : NSObject {
    var movieService : MovieService = MovieService()
    var movieList : [Movie] = [Movie]()
    var feedType : String = MovieService.URLs.now_playing {
        didSet {
            movieService.feedType = self.feedType
        }
    }
    
    var count : Int {
        get {
            return movieList.count
        }
    }
    
    override init() {
        super.init()
    }
    
    convenience init(feedType : String)
    {
        self.init()
        movieService.feedType = feedType
    }
    
    func loadMovies(error : ((NSError) -> ())? = nil,
                        success : (() -> ())? = nil) {
        movieService.loadMovies(error: { errorResult in
                                        print("ERROR: \(errorResult.description)")
                                        if let error = error {
                                            error(errorResult)
                                        }},
                                    success: { jsonData in
                                        self.parseNowPlayingJSON(json: jsonData)
                                        if let success = success {
                                            success()
                                        }
        })
    }
    
    func getMovieAtIndex(index:Int) -> Movie? {
        if (index < count) {
            return movieList[index]
        } else {
            return nil
        }
    }
    
    // parse the json result into a list of movies
    func parseNowPlayingJSON(json:JSON) {
        if let dataNodes = json.dictionary!["results"] {
            // If we had laoded items before sat lastLoadFirstItem to
            if let dataArray = dataNodes.array {
                for dataNode in dataArray {
                    let movie = Movie(movieJSON: dataNode)
                    movieList.append(movie)
                }
            }
        }
    }
}
