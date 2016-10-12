//
//  MovieTableController.swift
//  Flicks
//
//  Created by Scott Richards on 10/10/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieTableController: UITableViewController {
//    var movieService : MovieService = MovieService()
    var nowPlayingFeed : NowPlayingFeed = NowPlayingFeed()
    var selectedMovie : Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Following works with inline closure
/*        movieService.loadNowPlaying(error:
            {error in print("Error: \(error.description)")},
                                    success:
            { json in print("json: \(json)") }
        ) */
        // Can't get the following to compile calling
        nowPlayingFeed.loadNowPlaying(error:self.onError(error:),success:self.onSuccess)
    }

    func onSuccess() {
//        print("SUCCESS json: \(json)")
        self.tableView.reloadData()
    }
    
    func onError(error: NSError) {
        print("Error: \(error.description)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nowPlayingFeed.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let movieCell = cell as? MovieTableCell {
            if let movie = nowPlayingFeed.getMovieAtIndex(index: indexPath.row) {
                movieCell.setFromMovie(movie: movie)
            }
        }
        // Configure the cell...

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = nowPlayingFeed.getMovieAtIndex(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedMovie = nowPlayingFeed.getMovieAtIndex(index: indexPath.row)
        return indexPath
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destinationNavigationController = segue.destination as? UINavigationController {
            if let detailsViewController = destinationNavigationController.topViewController as? MovieDetailsController {
                detailsViewController.movie = selectedMovie
            }
        }
    }
 

}
