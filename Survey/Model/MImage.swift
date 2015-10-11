//
//  MImage.swift
//  Survey
//
//  Created by Apple on 10/11/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class MImage: Model,NSCoding {
   
    var pImageId:NSString!
    var pImageData:UIImage!
    
    override init() {}
    required init(coder aDecoder: NSCoder) {
        self.pImageId  = aDecoder.decodeObjectForKey("pImageId") as? NSString
        self.pImageData  = aDecoder.decodeObjectForKey("pImageData") as? UIImage
    }
    func encodeWithCoder(aCoder: NSCoder) {
        if let val = self.pImageId{
            aCoder.encodeObject(val, forKey: "pImageId")
        }
        if let val = self.pImageData{
            aCoder.encodeObject(val, forKey: "pImageData")
        }
    }
}
