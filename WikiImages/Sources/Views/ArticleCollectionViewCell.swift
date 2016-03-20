//
//  ArticleCollectionViewCell.swift
//  WikiImages
//
//  Created by Alexandre Santos on 19/03/16.
//  Copyright © 2016 Wikimedia. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = UIColor.blackColor()
    }
}
