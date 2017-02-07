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
import RxSwift

class PhotoViewSupplier {
    
    var contentMode: UIViewContentMode = .scaleAspectFit
    var items = [PhotosPublicItem]()
    
    var requestTask: URLSessionDataTask?
    var dispose: Disposable?
    
    init(contentMode: UIViewContentMode) {
        self.contentMode = contentMode
        let imageCache = SDImageCache.shared()
        imageCache.config.shouldCacheImagesInMemory = false
    }
    
    deinit {
        dispose?.dispose()
    }
    
    func getPhotoView(completion: @escaping (UIImageView?) -> Void) {
        print("item count = \(items.count)")
        if items.count == 0 {
            if dispose == nil {
                print("reload items!")
//                requestTask = APIRequester.photosPublic() { (success, model) in
//                    if success, let model = model {
//                        self.items.append(contentsOf: model.items)
//                        self.fetchNextItem(completion: completion)
//                        self.requestTask = nil
//                    }
//                }
                dispose = APIRequester.rxPhotosPublic()
                    .retry(10)
                    .subscribe(onNext: { [weak self] model in
                        guard let strongSelf = self else {
                            return
                        }
                        strongSelf.items.append(contentsOf: model.items)
                        strongSelf.fetchNextItem(completion: completion)
                        strongSelf.dispose = nil
                    }, onError: { error in
                        print("error occurred [\(error as NSError)]")
                })
                
//                dispose = APIRequester.rxPhotosPublic()
//                    .retry(10)
//                    .takeUntil(Observable.just(1))
//                    .subscribe { [weak self] e in
//                    guard let strongSelf = self else {
//                        return
//                    }
//
//                    switch e {
//                    case .next(let model):
//                        strongSelf.items.append(contentsOf: model.items)
//                        strongSelf.fetchNextItem(completion: completion)
//                        strongSelf.dispose = nil
//                    case .error(let error):
//                        print("error occurred [\(error as NSError)]")
//                    default:
//                        break
//                    }
//                }
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
