//
//  PhotosPublicModel.swift
//  FlickrShow
//
//  Created by hwangkyokook on 2016. 12. 4..
//  Copyright © 2016년 none. All rights reserved.
//

import Foundation

struct PhotosPublicModel {
    var title = ""
    var link = ""
    var desc = ""
    var modified: Date? = nil
    var generator = ""
    var items = [PhotosPublicItem]()
    
    mutating func parse(json: [String: Any]) {
        if let value = json["title"] as? String {
            title = value
        }
        if let value = json["link"] as? String {
            link = value
        }
        if let value = json["description"] as? String {
            desc = value
        }
        if let value = json["modified"] as? String {
            modified = Date.dateForFlickr(string: value)
        }
        if let value = json["generator"] as? String {
            generator = value
        }
        if let value = json["items"] as? [[String: Any]] {
            items = value.map { (raw) -> PhotosPublicItem in
                var item = PhotosPublicItem()
                item.parse(json: raw)
                return item
            }
        }
    }
}
