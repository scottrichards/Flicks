//
//  MovieTableController.swift
//  Flicks
//
//  Created by Scott Richards on 10/10/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class MovieTableController: UITableViewController {

    var movieFeed : MovieFeed = MovieFeed()
    var selectedMovie : Movie?
    var feedType : String = "now_playing"
    var loadingProgress : MBProgressHUD?
    var loadingError : LoadingView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Following works with inline closure
        loadingProgress = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingProgress?.label.text = "Loading movies..."
        movieFeed.feedType = feedType
        // Can't get the following to compile calling
        self.title = feedType == MovieService.URLs.now_playing ? "Now Playing" : "Top Rated"
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        movieFeed.loadMovies(error:self.onError(error:),success:self.onSuccess)
    }

    func onSuccess() {
        loadingProgress?.hide(animated: true)
        self.tableView.reloadData()
        loadingError = LoadingView.addToView(view: self.view, animated: true)
        loadingError?.message = "Loaded Movies"
        loadingProgress?.hide(animated: true)
    }
    
    func onError(error: NSError) {
        print("Error: \(error.description)")
        loadingError = LoadingView.addToView(view: self.view, animated: true)
        loadingError?.message = error.description
        loadingProgress?.hide(animated: true)
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
        return movieFeed.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let movieCell = cell as? MovieTableCell {
            if let movie = movieFeed.getMovieAtIndex(index: indexPath.row) {
                movieCell.setFromMovie(movie: movie)
            }
        }
        // Configure the cell...

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = movieFeed.getMovieAtIndex(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedMovie = movieFeed.getMovieAtIndex(index: indexPath.row)
        return indexPath
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected moview to the destination controller
        if let detailsViewController = segue.destination as? MovieDetailsController {
            detailsViewController.movie = selectedMovie
        }
        
//        if let destinationNavigationController = segue.destination as? UINavigationController {
//            if let detailsViewController = destinationNavigationController.topViewController as? MovieDetailsController {
//                detailsViewController.movie = selectedMovie
//            }
//        }
    }
 

}
