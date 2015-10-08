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
        let url = NSURL(string: "http://ws.audioscrobbler.com/2.0/?method=geo.gettoptracks&country=united+states&api_key=21f52413768b369a9f6b0af5aeb5f75e&format=json")
        let session = NSURLSession.sharedSession()
        var parseError : NSError?
        let task = session.downloadTaskWithURL(url!) {
            (loc:NSURL!, response:NSURLResponse!, error:NSError!) in
            let d = NSData(contentsOfURL: loc)!
            let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments, error: &parseError)
            self.parseJSONSwiftier(parsedObject!)
            dispatch_async(dispatch_get_main_queue()) {
                (UIApplication.sharedApplication().delegate as! AppDelegate).decrementNetworkActivity()
                self.tableView.reloadData()
            }
            
        }
        (UIApplication.sharedApplication().delegate as! AppDelegate).incrementNetworkActivity()
        task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - JSON parsing
    
    func parseJSON(parsedObject: AnyObject) {
        if let topLevelObject = parsedObject as? NSDictionary {
            if let topTracks = topLevelObject.objectForKey("toptracks") as? NSDictionary {
                if let tracks = topTracks.objectForKey("track") as? NSArray {
                    for t in tracks {
                        self.objects.append(t)
                    }
                }
            }
        }
    }
    
    /**
    This function is an attempt to use more Swift-default types than parseJSON by avoiding NSDictionaries and NSArrays. This has the advantage of being more consistent within Swift. Furthermore it requires a more precise declaration of types when type-casting.
    */
    func parseJSONSwiftier(parsedObject: AnyObject) {
        if let topLevelObject = parsedObject as? Dictionary<String, AnyObject> {
            if let topTracks = topLevelObject["toptracks"] as? Dictionary<String,AnyObject> {
                if let tracks = topTracks["track"] as? Array<AnyObject> {
                    for t in tracks {
                        self.objects.append(t)
                    }
                }
            }
        }
    }



    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as! Dictionary<String, AnyObject>
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
            if let firstImage = image[2] as? NSDictionary {
                if let imageUrl = firstImage["#text"] as? String {
                    cell.imageView?.loadImageFromURL(NSURL(string:imageUrl),
                        placeholderImage: cell.imageView?.image, cachingKey: imageUrl)
                }
            }
        }

        return cell
    }



}

