//
//  PhotosPublicModel.swift
//  FlickrShow
//
//  Created by hwangkyokook on 2016. 12. 4..
//  Copyright © 2016년 none. All rights reserved.
//

import Foundation
import ObjectMapper

struct PhotosPublicModel: Mappable {
    var title: String?
    var link: String?
    var desc: String?
    var modified: Date?
    var generator: String?
    var items: [PhotosPublicItem] = []
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        link <- map["link"]
        desc <- map["description"]
        modified <- map["modified"]
        generator <- map["generator"]
        items <- map["items"]
    }
}
