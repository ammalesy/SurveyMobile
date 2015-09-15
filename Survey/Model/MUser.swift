//
//  MUser.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/15/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

class MUser: Model,NSCoding {
    var pU_id:NSString!
    var pU_firstname:NSString!
    var pU_surname:NSString!
    var pU_sex:NSInteger!
    var pU_age:NSInteger!
    var pU_email:NSString!
    
    override init() {}
    required init(coder aDecoder: NSCoder) {
        self.pU_id  = aDecoder.decodeObjectForKey("pU_id") as? NSString
        self.pU_firstname  = aDecoder.decodeObjectForKey("pU_firstname") as? NSString
        self.pU_surname  = aDecoder.decodeObjectForKey("pU_surname") as? NSString
        self.pU_sex  = aDecoder.decodeObjectForKey("pU_sex") as? NSInteger
        self.pU_age  = aDecoder.decodeObjectForKey("pU_age") as? NSInteger
        self.pU_email  = aDecoder.decodeObjectForKey("pU_email") as? NSString
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let val = self.pU_id{
            aCoder.encodeObject(val, forKey: "pU_id")
        }
        if let val = self.pU_firstname{
            aCoder.encodeObject(val, forKey: "pU_firstname")
        }
        if let val = self.pU_surname{
            aCoder.encodeObject(val, forKey: "pU_surname")
        }
        if let val = self.pU_sex{
            aCoder.encodeObject(val, forKey: "pU_sex")
        }
        if let val = self.pU_age{
            aCoder.encodeObject(val, forKey: "pU_age")
        }
        if let val = self.pU_email{
            aCoder.encodeObject(val, forKey: "pU_email")
        }
    }
    
}
