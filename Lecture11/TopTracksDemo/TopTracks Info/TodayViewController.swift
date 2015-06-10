//
//  TodayViewController.swift
//  TopTracks Info
//
//  Created by Jonathan Engelsma on 6/9/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var artist3: UILabel!
    @IBOutlet weak var track3: UILabel!
    @IBOutlet weak var artist2: UILabel!
    @IBOutlet weak var track2: UILabel!
    @IBOutlet weak var artist1: UILabel!
    @IBOutlet weak var track1: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    var expanded : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSizeMake(0, 50)
        self.track1.text = "---"
        self.artist1.text = "---"
        self.track2.text = "---"
        self.artist2.text = "---"
        self.track3.text = "---"
        self.artist3.text = "---"
        
        let url = NSURL(string: "http://ws.audioscrobbler.com/2.0/?method=geo.gettoptracks&country=united+states&api_key=21f52413768b369a9f6b0af5aeb5f75e&format=json")
        let session = NSURLSession.sharedSession()
        var parseError : NSError?
        let task = session.downloadTaskWithURL(url!) {
            (loc:NSURL!, response:NSURLResponse!, error:NSError!) in
            let d = NSData(contentsOfURL: loc)!
            let parsedObject: AnyObject?  =
            NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments, error: &parseError)
            if let topLevelObject = parsedObject as? NSDictionary {
                if let topTracks = topLevelObject.objectForKey("toptracks") as? NSDictionary {
                    if let tracks = topTracks.objectForKey("track") as? NSArray {
                        dispatch_async(dispatch_get_main_queue()) {
                            var track = tracks[0] as! NSDictionary
                            self.track1.text = track.objectForKey("name") as? String
                            var artist = track.objectForKey("artist") as? NSDictionary
                            self.artist1.text = artist?.objectForKey("name") as? String
                            
                            track = tracks[1] as! NSDictionary
                            self.track2.text = track.objectForKey("name") as? String
                            artist = track.objectForKey("artist") as? NSDictionary
                            self.artist2.text = artist?.objectForKey("name") as? String

                            track = tracks[2] as! NSDictionary
                            self.track3.text = track.objectForKey("name") as? String
                            artist = track.objectForKey("artist") as? NSDictionary
                            self.artist3.text = artist?.objectForKey("name") as? String
                        }
                    }
                }
            }
            
            
        }
        task.resume()

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction func launchContainerApp(sender: AnyObject) {
        
        let url = NSURL(string: "toptracks://")
        self.extensionContext?.openURL(url!, completionHandler: nil)
    }
    
    @IBAction func showMore(sender: AnyObject) {
        if self.expanded {
            self.preferredContentSize = CGSizeMake(0, 50)
            self.showMoreButton.transform = CGAffineTransformMakeRotation(CGFloat(180.0 * M_PI / 180.0))
            self.expanded = false
        } else {
            self.preferredContentSize = CGSizeMake(0, 250)
            self.showMoreButton.transform = CGAffineTransformMakeRotation(CGFloat(180.0 * M_PI / 180.0))
            self.expanded = true
        }
    }
}
