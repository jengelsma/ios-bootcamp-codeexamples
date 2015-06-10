//
//  CustomWebViewController.swift
//  TopTracksDemo
//
//  Created by Jonathan Engelsma on 5/26/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit

class CustomWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var webUrl : String?
    var _webActivityIndicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activity : UIBarButtonItem = UIBarButtonItem(customView: self.webActivityIndicator())
        let safari : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "viewInSafari")
        
        self.navigationItem.rightBarButtonItems = [safari,activity]

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let theUrl : NSURL? = NSURL(string: self.webUrl!)
        
        let request : NSMutableURLRequest? = NSMutableURLRequest(URL: theUrl!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
        
        request!.HTTPMethod = "GET"
        self.webView!.delegate = self
        self.webView.loadRequest(request!)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if self.webView.loading {
            self.webView.stopLoading()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webActivityIndicator() -> UIActivityIndicatorView
    {
        if self._webActivityIndicator == nil {
            self._webActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
            self._webActivityIndicator?.hidesWhenStopped = true
        }
        return self._webActivityIndicator!
    }
    
    func viewInSafari() {
        let url : NSURL? = NSURL(string: self.webUrl!)
        if !UIApplication.sharedApplication().openURL(url!) {
            println("Failed to open " + self.webUrl!)
        }
    }
    
    func backPressed() {
        if self.webView.canGoBack {
            self.webView.goBack()
        }
    }
    
    func updateBackButton() {
        if self.webView.canGoBack {
            if self.navigationItem.leftBarButtonItem == nil {
                self.navigationItem.hidesBackButton = true
                let backItem : UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backPressed")
                self.navigationItem.leftBarButtonItem = backItem
            }
        } else {
                self.navigationItem.leftBarButtonItem = nil
                self.navigationItem.hidesBackButton = false
        }
    }

    func webViewDidStartLoad(webView: UIWebView)
    {
        self.webActivityIndicator().startAnimating()
        self.updateBackButton()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.webActivityIndicator().stopAnimating()
        self.updateBackButton()
    }

    func webView(webView: UIWebView,
        didFailLoadWithError error: NSError) {
            self.webActivityIndicator().stopAnimating()
            println("error loading page!")
    }
    

}
