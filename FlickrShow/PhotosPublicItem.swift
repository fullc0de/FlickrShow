//
//  PhotosPublicItem.swift
//  FlickrShow
//
//  Created by hwangkyokook on 2016. 12. 4..
//  Copyright © 2016년 none. All rights reserved.
//

import Foundation
import ObjectMapper

struct PhotosPublicItem: Mappable {
    var title: String?
    var link: String?
    var media: [String: String] = [:]
    var dateTaken: Date?
    var desc: String?
    var published: Date?
    var author: String?
    var tags: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        link <- map["link"]
        media <- map["media"]
        dateTaken <- map["date_taken"]
        desc <- map["description"]
        published <- map["published"]
        author <- map["author"]
        tags <- map["tags"]
    }
    
    func largeImageURLString() -> String? {
        if let value = media["m"] {
            return value.replacingOccurrences(of: "_m.", with: "_b.")
        }
        return nil
    }
}
