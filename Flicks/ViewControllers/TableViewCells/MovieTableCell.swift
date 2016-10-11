//
//  MovieTableCell.swift
//  Flicks
//
//  Created by Scott Richards on 10/11/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit

class MovieTableCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!

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
    }
}
