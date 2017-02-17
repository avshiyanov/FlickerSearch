//
//  FlickrPhotoViewCell.swift
//  FlickFinder
//
//  Created by Artem Shyianov on 2/17/17.
//  Copyright © 2017 Artem Shyianov. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

let kFlickrPhotoIdentifier = "flickrPhotoCellIdentifier"

class FlickrPhotoViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(photo: FlickrPhoto) {
        if let url = URL(string: photo.imageUrl) {
            imageView.af_setImage(withURL: url)
        }
    }
    
    override func prepareForReuse() {
        imageView.af_cancelImageRequest()
        imageView.image = nil
    }
}
