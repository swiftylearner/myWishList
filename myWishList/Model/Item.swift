//
//  File.swift
//  myWishList
//
//  Created by MacBook on 5/26/19.
//  Copyright © 2019 Apptive. All rights reserved.
//

import UIKit

struct Items {
    var title:String
    var price:String
    
    init(title:String,price:String) {
        self.title = title
        self.price = "$\(price)"
    }
}
