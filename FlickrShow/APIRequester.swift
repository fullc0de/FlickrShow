//
//  APIRequester.swift
//  FlickrShow
//
//  Created by hwangkyokook on 2016. 12. 4..
//  Copyright © 2016년 none. All rights reserved.
//

import Foundation

class APIRequester {
    class func photosPublic(completion: @escaping (Bool, PhotosPublicModel?) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1") else {
            return nil
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
     
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!)
                DispatchQueue.main.async { completion(false, nil) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(false, nil) }
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [String: Any]
                var model = PhotosPublicModel()
                model.parse(json: json)
                DispatchQueue.main.async { completion(true, model) }
            } catch let jsonError {
                print(jsonError)
                DispatchQueue.main.async { completion(false, nil) }
            }
            
        }
        task.resume()
        return task
    }
}
