//
//  ViewController.swift
//  LifeCycleDemo
//
//  Created by Jonathan Engelsma on 5/14/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pretty_function("Called")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        pretty_function("Called")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        pretty_function("Called")
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        pretty_function("Called")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        pretty_function("Called")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

