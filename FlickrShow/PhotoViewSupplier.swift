//
//  PhotoViewSupplier.swift
//  FlickrShow
//
//  Created by hwangkyokook on 2016. 12. 3..
//  Copyright © 2016년 none. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

class PhotoViewSupplier {
    
    var contentMode: UIViewContentMode = .scaleAspectFit
    var items = [PhotosPublicItem]()
    
    var requestTask: URLSessionDataTask?
    
    init(contentMode: UIViewContentMode) {
        self.contentMode = contentMode
        let imageCache = SDImageCache.shared()
        imageCache.config.shouldCacheImagesInMemory = false
    }
    
    func getPhotoView(completion: @escaping (UIImageView?) -> Void) {
        print("item count = \(items.count)")
        if items.count == 0 {
            if requestTask == nil {
                print("reload items!")
                requestTask = APIRequester.photosPublic() { (success, model) in
                    if success, let model = model {
                        self.items.append(contentsOf: model.items)
                        self.fetchNextItem(completion: completion)
                        self.requestTask = nil
                    }
                }
            }
        } else {
            fetchNextItem(completion: completion)
        }
    }
    
    func fetchNextItem(completion: @escaping (UIImageView?) -> Void) {
        let first = items.removeFirst()
        if let urlstring = first.largeImageURLString() {
            let url = URL(string: urlstring)
            let pv = UIImageView(image: nil)
            pv.contentMode = contentMode
            pv.sd_setImage(with: url) { (image, error, _, _) in
                if let image = image {
                    let size = image.size
                    print("size = \(size.width * size.height) (\(size.width) x \(size.height))")
                }
                completion(pv)
            }
        }
    }
}
