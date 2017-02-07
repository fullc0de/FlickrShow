//
//  PhotoShowViewController.swift
//  FlickrShow
//
//  Created by hwangkyokook on 2016. 12. 3..
//  Copyright © 2016년 none. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoShowViewController: UIViewController {

    @IBOutlet weak var photoBaseView: UIView!
    @IBOutlet weak var intervalSlider: UISlider!
    @IBOutlet weak var intervalLabel: UILabel!
    
    
    let supplier = PhotoViewSupplier(contentMode: .scaleAspectFit)
    var currentImageView: UIImageView?
    var timer: Timer!
    var timeInterval = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateIntervalUI(value: 1)
        updatePhoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updatePhoto() {
        supplier.getPhotoView { (imageView) in
            if let imageView = imageView {
                self.showNext(newImageView: imageView)
            }
            
            let deadline = DispatchTime.now() + .seconds(self.timeInterval)
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                self.updatePhoto()
            }
        }
    }
    
    func showNext(newImageView: UIImageView) {
        photoBaseView.addSubview(newImageView)
        newImageView.applyMarginConstraint(inset: UIEdgeInsets.zero)
        
        newImageView.alpha = 0.0
        UIView.animate(withDuration: 0.4, animations: {
            if let currentImageView = self.currentImageView {
                currentImageView.alpha = 0.0
            }
            newImageView.alpha = 1.0
        }, completion: { (complete) in
            if let currentImageView = self.currentImageView {
                currentImageView.removeFromSuperview()
            }
            self.currentImageView = newImageView
        })
    }
    
    func updateIntervalUI(value: Int) {
        intervalSlider.setValue(Float(value), animated: true)
        intervalLabel.text = String(format: "%ld sec", value)
    }
    
    @IBAction func intervalChanged(_ sender: UISlider) {
        let roundedValue = lroundf(sender.value)
        timeInterval = roundedValue
        
        updateIntervalUI(value: roundedValue)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
