//
//  PhotosPublicItem.swift
//  FlickrShow
//
//  Created by hwangkyokook on 2016. 12. 4..
//  Copyright © 2016년 none. All rights reserved.
//

import Foundation

struct PhotosPublicItem {
    var title = ""
    var link = ""
    var media = [String: String]()
    var dateTaken: Date? = nil
    var desc = ""
    var published: Date? = nil
    var author = ""
    var authorID = ""
    var tags = ""
    
    mutating func parse(json: [String: Any]) {
        if let value = json["title"] as? String {
            title = value
        }
        if let value = json["link"] as? String {
            link = value
        }
        if let value = json["media"] as? [String: String] {
            media = value
        }
        if let value = json["description"] as? String {
            desc = value
        }
        if let value = json["date_taken"] as? String {
            dateTaken = Date.dateForFlickr(string: value)
        }
        if let value = json["published"] as? String {
            published = Date.dateForFlickr(string: value)
        }
        if let value = json["author"] as? String {
            author = value
        }
        if let value = json["tags"] as? String {
            tags = value
        }
    }
    
    func largeImageURLString() -> String? {
        if let value = media["m"] {
            return value.replacingOccurrences(of: "_m.", with: "_b.")
        }
        return nil
    }
}
