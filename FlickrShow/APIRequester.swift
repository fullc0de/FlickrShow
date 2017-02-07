//
//  APIRequester.swift
//  FlickrShow
//
//  Created by hwangkyokook on 2016. 12. 4..
//  Copyright © 2016년 none. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

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

            if let jsonString = String(data: data, encoding: .utf8) {
                let model = PhotosPublicModel(JSONString: jsonString)
                DispatchQueue.main.async { completion(true, model) }
            } else {
                DispatchQueue.main.async { completion(false, nil) }
            }
        }
        task.resume()
        return task
    }
    
    class func rxPhotosPublic() -> Observable<PhotosPublicModel> {
        return string(.get, "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")
            .observeOn(MainScheduler.instance)
            .map { jsonString in
                guard let model = PhotosPublicModel(JSONString: jsonString) else {
                    throw RxError.unknown
                }
                return model
            }
    }
}
