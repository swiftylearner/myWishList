//
//  Extensions.swift
//  myWishList
//
//  Created by MacBook on 5/25/19.
//  Copyright © 2019 Apptive. All rights reserved.
//

import UIKit

extension UIView {
    
    func shake(){
        let shaked = CABasicAnimation(keyPath: "position")
        shaked.duration = 0.1
        shaked.repeatCount = 2
        
        let fromPoint = CGPoint(x: self.center.x - 8, y: self.center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: self.center.x + 8, y: self.center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shaked.fromValue = fromValue
        shaked.toValue = toValue
        
        self.layer.add(shaked, forKey: "position")
    }
    
}
