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

    var detailItem: Dictionary<String, AnyObject>? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.trackName {
                label.text = detail["name"] as? String
            }
            if let label = self.artistName {
                let artist = detail["artist"] as? Dictionary<String,String>
                label.text = artist?["name"]
            }
            
            if let imageView = self.albumImage {
                imageView.image = UIImage(named: "Last_fm_logo")
                if let images = detail["image"] as? Array<AnyObject> {
                    if let thirdImage = images[2] as? Dictionary<String,String> {
                        if let imageUrl = thirdImage["#text"]  {
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
            var mobileUrl = self.detailItem!["url"] as? String
            mobileUrl = mobileUrl?.stringByReplacingOccurrencesOfString("www.last.fm", withString: "m.last.fm")
            (segue.destinationViewController as? CustomWebViewController)?.webUrl = mobileUrl
            (segue.destinationViewController as? CustomWebViewController)?.title = "Track"
        } else if sender as? UIButton == self.artistButton {
            var artist = self.detailItem!["artist"] as? Dictionary<String, String>
            var mobileUrl = artist?["url"] 
            mobileUrl = mobileUrl?.stringByReplacingOccurrencesOfString("www.last.fm", withString: "m.last.fm")
            (segue.destinationViewController as? CustomWebViewController)?.webUrl = mobileUrl
            (segue.destinationViewController as? CustomWebViewController)?.title = "Artist"
        }
    }


}

