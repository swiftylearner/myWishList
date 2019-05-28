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


extension UITextField {
    
    func custom(placeHolder:String,size:CGFloat){
        let color = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor:color])
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        textColor = .white
        keyboardType = .numberPad
        font = UIFont.systemFont(ofSize: size)
    }
    
}


extension UIImageView {
    
    func configure(image:String) {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        self.image = UIImage(named:image)?.withRenderingMode(.alwaysOriginal)
    }
}
