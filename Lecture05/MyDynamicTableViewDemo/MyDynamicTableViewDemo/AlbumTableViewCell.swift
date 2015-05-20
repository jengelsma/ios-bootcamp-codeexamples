//
//  AlbumTableViewCell.swift
//  MyDynamicTableViewDemo
//
//  Created by Jonathan Engelsma on 5/19/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit
import AssetsLibrary

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbNail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFromAlbum(album: ALAssetsGroup) {
        self.thumbNail!.image = UIImage(CGImage: album.posterImage().takeUnretainedValue())
        self.title!.text = album.valueForProperty(ALAssetsGroupPropertyName) as? String
    }

}
