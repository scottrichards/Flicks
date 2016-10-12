//
//  Movie.swift
//  Flicks
//
//  Created by Scott Richards on 10/11/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import SwiftyJSON

class Movie: NSObject {
    var id : Int?    // unique id
    var title : String? // movie title i.e. "The magnificent Seven"
    var overview : String?  // movie summary
    var popularity : NSNumber?   // popularity a number like 24.44753 (not sure what this is)
    var rating : NSNumber?       // vote_average (rating from 0-5)
    var releaseDate : Date?   // movie release date
    var poster : String?    // path to the poster artwork
    
    static var _inputDateFormatter : DateFormatter? = nil
    static var inputDateFormatter: DateFormatter {
        get {
            if let _inputDateFormatter = _inputDateFormatter {
                return _inputDateFormatter
            } else {
                _inputDateFormatter = DateFormatter()
                _inputDateFormatter?.dateFormat = "yyyy-MM-dd"
                _inputDateFormatter?.timeZone = NSTimeZone(name: "GMT") as TimeZone!
                return _inputDateFormatter!
            }
        }
    }
    
    init(movieJSON:JSON) {
        if let idInt = movieJSON["id"].int {
            id = idInt
        }
        if let titleStr = movieJSON["title"].string {
            title = titleStr
        }
        if let overviewStr = movieJSON["overview"].string {
            overview = overviewStr
        }
        if let popularityNumber = movieJSON["popularity"].number {
            popularity = popularityNumber
        }
        if let ratingNumber = movieJSON["popularity"].number {
            rating = ratingNumber
        }
        if let releaseDateStr = movieJSON["release_date"].string {
            releaseDate = Movie.inputDateFormatter.date(from: releaseDateStr)
        }
        if let posterStr = movieJSON["poster_path"].string {
            poster = posterStr
        }
    }
}
