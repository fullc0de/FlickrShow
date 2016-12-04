//
//  UIViewExtension.swift
//  FlickrShow
//
//  Created by hwangkyokook on 2016. 12. 4..
//  Copyright © 2016년 none. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func applyMarginConstraint(inset: UIEdgeInsets) {
        if superview == nil {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let dic = ["view": self]
        let metrics = ["left": inset.left, "right": inset.right, "top": inset.top, "bottom": inset.bottom]
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[view]-right-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: dic))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[view]-bottom-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: dic))
        superview?.addConstraints(constraints)
    }
}
