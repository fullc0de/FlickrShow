//
//  DateExtension.swift
//  FlickrShow
//
//  Created by hwangkyokook on 2016. 12. 4..
//  Copyright © 2016년 none. All rights reserved.
//

import Foundation

extension Date {
    public static let flickrDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    
    static func dateForFlickr(string: String) -> Date? {
        return Date.flickrDateFormatter.date(from: string)
    }
}
