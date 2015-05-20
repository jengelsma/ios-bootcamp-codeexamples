//
//  MyAssetsLibrary.swift
//  MyDynamicTableViewDemo
//
//  Created by Jonathan Engelsma on 5/19/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import Foundation
import AssetsLibrary

class MyAssetsLibrary: ALAssetsLibrary
{
    static let singleton = MyAssetsLibrary()
    
    class func defaultInstance() -> MyAssetsLibrary
    {
        return singleton
    }
}