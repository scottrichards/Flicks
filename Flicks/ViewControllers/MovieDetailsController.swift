//
//  MovieDetailsController.swift
//  Flicks
//
//  Created by Scott Richards on 10/12/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailsController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var summary: UILabel!
    var movie : Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            movieName.text = movie.title
            summary.text = movie.overview
            if let posterPath = movie.poster {
                let posterURL = MovieService.URLs.Poster500 + posterPath // + MovieService.appendAPIKey()
                print("posterURL: \(posterURL)")
                Alamofire.request(posterURL).responseImage { response in
                    // if we got an image response set the profile image and hide the label otherwise be sure to show intials label
                    if let image = response.result.value {
                        self.posterImageView.image = image
                    } else {
                        self.posterImageView.image = nil
                    }
                }
            } else {
                posterImageView.image = nil
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
  
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected moview to the destination controller
        if let playTrailerController = segue.destination as? PlayTrailerController {
            playTrailerController.movie = movie
        }
        
    }

}
