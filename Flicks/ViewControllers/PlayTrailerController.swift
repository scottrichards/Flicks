//
//  PlayTrailerController.swift
//  Flicks
//
//  Created by Scott Richards on 10/12/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import AVFoundation

class PlayTrailerController: UIViewController {
    
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var fastForwardButton: UIButton!
    @IBOutlet weak var playerView: PlayerView!
    
    // Attempt load and test these asset keys before playing.
    static let assetKeysRequiredToPlay = [
        "playable",
        "hasProtectedContent"
    ]
    
    static let movieURL = "https://devimages.apple.com.edgekey.net/samplecode/avfoundationMedia/AVFoundationQueuePlayer_Progressive.mov"
    
    var movie : Movie?
    let player = AVQueuePlayer()
    var loadedAssets = [String: AVURLAsset]()

    
        // ------------------------------------
    // MARK: Properties
    // ------------------------------------
    
    var currentTime: Double {
        get {
            return CMTimeGetSeconds(player.currentTime())
        }
        
        set {
            let newTime = CMTimeMakeWithSeconds(newValue, 1)
            player.seek(to: newTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        }
    }
    
    var duration: Double {
        guard let currentItem = player.currentItem else { return 0.0 }
        
        return CMTimeGetSeconds(currentItem.duration)
    }
    
    var rate: Float {
        get {
            return player.rate
        }
        
        set {
            player.rate = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer? {
        return playerView.playerLayer
    }
    
    /*
     A formatter for individual date components used to provide an appropriate
     value for the `startTimeLabel` and `durationLabel`.
     */
    let timeRemainingFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        
        return formatter
    }()

    // ------------------------------------
    // MARK: Life cycle events
    // ------------------------------------

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie?.title
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
     Prepare an AVAsset for use on a background thread. When the minimum set
     of properties we require (`assetKeysRequiredToPlay`) are loaded then add
     the asset to the `assetTitlesAndThumbnails` dictionary. We'll use that
     dictionary to populate the "Add Item" button popover.
     */
    func asynchronouslyLoadURLAsset(asset: AVURLAsset, title: String) {
        /*
         Using AVAsset now runs the risk of blocking the current thread (the
         main UI thread) whilst I/O happens to populate the properties. It's
         prudent to defer our work until the properties we need have been loaded.
         */
        asset.loadValuesAsynchronously(forKeys: PlayTrailerController.assetKeysRequiredToPlay) {
            
            /*
             The asset invokes its completion handler on an arbitrary queue.
             To avoid multiple threads using our internal state at the same time
             we'll elect to use the main thread at all times, let's dispatch
             our handler to the main queue.
             */
            DispatchQueue.main.async() {
                /*
                 This method is called when the `AVAsset` for our URL has
                 completed the loading of the values of the specified array
                 of keys.
                 */
                
                /*
                 Test whether the values of each of the keys we need have been
                 successfully loaded.
                 */
                for key in PlayTrailerController.assetKeysRequiredToPlay {
                    var error: NSError?
                    
                    if asset.statusOfValue(forKey: key, error: &error) == .failed {
                        let stringFormat = NSLocalizedString("error.asset_%@_key_%@_failed.description", comment: "Can't use this AVAsset because one of it's keys failed to load")
                        
                        let message = String.localizedStringWithFormat(stringFormat, title, key)
                        
                        self.handleError(with: message, error: error)
                        
                        return
                    }
                }
                
                // We can't play this asset.
                if !asset.isPlayable || asset.hasProtectedContent {
                    let stringFormat = NSLocalizedString("error.asset_%@_not_playable.description", comment: "Can't use this AVAsset because it isn't playable or has protected content")
                    
                    let message = String.localizedStringWithFormat(stringFormat, title)
                    
                    self.handleError(with: message)
                    
                    return
                }
                
                /*
                 We can play this asset. Create a new AVPlayerItem and make it
                 our player's current item.
                 */
                  self.loadedAssets[title] = asset
                
//                let name = (thumbnailResourceName as NSString).deletingPathExtension
//                let type = (thumbnailResourceName as NSString).pathExtension
//                let path = Bundle.main.path(forResource: name, ofType: type)!
                
//                let thumbnail = UIImage(contentsOfFile: path)!
                
//                self.assetTitlesAndThumbnails[asset.url] = (title, thumbnail)
            }
        }
    }

    // MARK: Error Handling
    
    func handleError(with message: String?, error: Error? = nil) {
        NSLog("Error occurred with message: \(message), error: \(error).")
        
        let alertTitle = NSLocalizedString("alert.error.title", comment: "Alert title for errors")
        
        let alertMessage = message ?? NSLocalizedString("error.default.description", comment: "Default error message when no NSError provided")
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let alertActionTitle = NSLocalizedString("alert.error.actions.OK", comment: "OK on error alert")
        let alertAction = UIAlertAction(title: alertActionTitle, style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
