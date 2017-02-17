//
//  FlickrAPIService.swift
//  FlickFinder
//
//  Created by Artem Shyianov on 2/17/17.
//  Copyright © 2017 Artem Shyianov. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import SwiftyJSON

struct FlickrAPIService {
    
    struct Constants {
        static let baseURL = "https://api.flickr.com/services/rest/"
        static let apiKey  = "b34e2094e8ab37e0a3650f8f95a90750"
    }
    
    enum ResourcePath: String {
        case photosSearch = "flickr.photos.search"
        
        var path: String {
            return Constants.baseURL
        }
    }
    
    enum APIError: Error {
        case cannotParse
        case connectionProblem
    }
    
    func getPhotos(text: String) -> Observable<[FlickrPhoto]> {
        let params = [
            "text"  : text,
            "method" : "flickr.photos.search",
            "api_key" : Constants.apiKey,
            "extras" : "url_m",
            "format" : "json",
            "nojsoncallback" : "1"
        ]
        
        if let url = URL(string: ResourcePath.photosSearch.path) {
            return json(.get, url, parameters: params).flatMap({
                (result) -> Observable<[FlickrPhoto]> in
                
                var results: [FlickrPhoto] = []
                if let dict = result as? [String: AnyObject] {
                    if let photos = dict["photos"] {
                        guard let array = photos["photo"] as? [Any] else {
                            return Observable.error(APIError.cannotParse)
                        }
                        
                        for dict in array {
                            if let photo = FlickrPhoto(json: JSON(dict)) {
                                results.append(photo)
                            }
                        }
                    }
                }
                return Observable.just(results)
            }).observeOn(MainScheduler.instance)
        } else {
            return Observable.empty()
        }
    }
}
