//
//  File.swift
//  myWishList
//
//  Created by MacBook on 5/26/19.
//  Copyright © 2019 Apptive. All rights reserved.
//

import UIKit

struct Items : Equatable {
    var title:String
    var price:Double
    
    init(title:String,price:String) {
        self.title = title
        self.price = Double(price) ?? 0.0
    }
}
