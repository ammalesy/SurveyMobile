//
//  Extension.swift
//  Survey
//
//  Created by Apple on 10/11/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class Extension: NSObject {
   
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hexString:NSString) {
        var rgbValue:UInt32 = 0;
        var scanner:NSScanner = NSScanner(string: hexString as String)
        scanner.scanLocation = 1
        scanner.scanHexInt(&rgbValue)
        var hex:Int = Int(rgbValue)
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}
