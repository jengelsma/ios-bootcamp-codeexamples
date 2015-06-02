//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let testObject = PFObject(className: "Widgets")
        testObject["name"] = "junk widget"
        testObject["description"] = "A very junky widget"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Object has been saved")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func readData(sender: AnyObject) {
        var query = PFQuery(className: "Widgets")
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
            if object != nil && error == nil {
                let widget = object?.objectForKey("name") as! String
                println(widget)
            } else {
                println(error)
            }
            
        }
    }
}

