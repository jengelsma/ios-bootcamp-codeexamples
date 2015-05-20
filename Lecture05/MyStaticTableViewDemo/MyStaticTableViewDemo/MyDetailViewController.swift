//
//  MyDetailViewController.swift
//  MyStaticTableViewDemo
//
//  Created by Jonathan Engelsma on 5/19/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit

class MyDetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    
    var myString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailLabel.text = self.myString

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
