//
//  DetailViewController.swift
//  TopTracksDemo
//
//  Created by Jonathan Engelsma on 5/26/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artistButton: UIButton!
    @IBOutlet weak var trackButton: UIButton!

    var detailItem: NSDictionary? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: NSDictionary = self.detailItem {
            if let label = self.trackName {
                label.text = detail.objectForKey("name") as? String
            }
            if let label = self.artistName {
                let artist = detail.objectForKey("artist") as? NSDictionary
                label.text = artist?.objectForKey("name") as? String
            }
            
            if let imageView = self.albumImage {
                imageView.image = UIImage(named: "Last_fm_logo")
                if let images = detail.objectForKey("image") as? NSArray {
                    if let thirdImage = images[2] as? NSDictionary {
                        if let imageUrl = thirdImage["#text"] as? String {
                            imageView.loadImageFromURL(NSURL(string:imageUrl),
                                placeholderImage: imageView.image, cachingKey: imageUrl)
                        }
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as? UIButton == self.trackButton {
            var mobileUrl = self.detailItem!.objectForKey("url") as? String
            mobileUrl = mobileUrl?.stringByReplacingOccurrencesOfString("www.last.fm", withString: "m.last.fm")
            (segue.destinationViewController as? CustomWebViewController)?.webUrl = mobileUrl
            (segue.destinationViewController as? CustomWebViewController)?.title = "Track"
        } else if sender as? UIButton == self.artistButton {
            var artist = self.detailItem!.objectForKey("artist") as? NSDictionary
            var mobileUrl = artist?.objectForKey("url") as? String
            mobileUrl = mobileUrl?.stringByReplacingOccurrencesOfString("www.last.fm", withString: "m.last.fm")
            (segue.destinationViewController as? CustomWebViewController)?.webUrl = mobileUrl
            (segue.destinationViewController as? CustomWebViewController)?.title = "Artist"
        }
    }


}

