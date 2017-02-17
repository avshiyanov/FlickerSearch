//
//  FlickrImage.swift
//  FlickFinder
//
//  Created by Artem Shyianov on 2/17/17.
//  Copyright © 2017 Artem Shyianov. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FlickrPhoto {
    // MARK: - Properties
    
    let photoId: String!
    let imageUrl: String
    
    init?(json: JSON) {
        guard
            let photoId = json["id"].string,
            let imageUrl = json["url_m"].string
            else {
                return nil
        }
        self.photoId = photoId
        self.imageUrl = imageUrl
    }
}
