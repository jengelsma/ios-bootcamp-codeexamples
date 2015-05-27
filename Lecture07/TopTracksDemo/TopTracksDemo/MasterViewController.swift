//
//  MasterViewController.swift
//  TopTracksDemo
//
//  Created by Jonathan Engelsma on 5/26/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [AnyObject]()


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Update the URL in the following line with an API KEY of your own from last.fm.
        let url = NSURL(string: "http://ws.audioscrobbler.com/2.0/?method=geo.gettoptracks&country=united+states&api_key=YOUR_API_KEY_GOES_HERE&format=json")
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
                        for t in tracks {
                            self.objects.append(t)
                        }
                        dispatch_async(dispatch_get_main_queue()) {
                            (UIApplication.sharedApplication().delegate as! AppDelegate).decrementNetworkActivity()
                            self.tableView.reloadData()
                        }
                    }
                }
            }

            
        }
        (UIApplication.sharedApplication().delegate as! AppDelegate).incrementNetworkActivity()
        task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as! NSDictionary
                (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // track name
        let track = objects[indexPath.row] as! NSDictionary
        cell.textLabel!.text = track.objectForKey("name") as? String
        
        // artist name
        let artist = track.objectForKey("artist") as? NSDictionary
        cell.detailTextLabel!.text = artist?.objectForKey("name") as? String

        // thumbnail image
        cell.imageView?.image = UIImage(named: "Last_fm_logo")
        if let image = track.objectForKey("image") as? NSArray {
            if let firstImage = image[0] as? NSDictionary {
                if let imageUrl = firstImage["#text"] as? String {
                    cell.imageView?.loadImageFromURL(NSURL(string:imageUrl),
                        placeholderImage: cell.imageView?.image, cachingKey: imageUrl)
                }
            }
        }
        
        return cell
    }



}

