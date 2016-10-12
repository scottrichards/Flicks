//
//  MovieTableCell.swift
//  Flicks
//
//  Created by Scott Richards on 10/11/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import Alamofire

class MovieTableCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setFromMovie(movie:Movie) {
        self.title.text = movie.title
        self.overview.text = movie.overview
        if let posterPath = movie.poster {
            let posterURL = MovieService.URLs.Poster150 + posterPath + MovieService.appendAPIKey()
            print("posterURL: \(posterURL)")
//            Alamofire.request(.GET, posterURL).responseImage { response in
//                // if we got an image response set the profile image and hide the label otherwise be sure to show intials label
//                if let image = response.result.value {
//                    self.profileImageView.image = image
//                    self.initialsLabel.hidden = true
//                } else {
//                    self.initialsLabel.hidden = false
//                    self.profileImageView.image = nil
//                }
//            }
        } else {
            posterImageView.image = nil
        }

    }
}
