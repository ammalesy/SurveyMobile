//
//  MProject.swift
//  Survey
//
//  Created by Apple on 10/17/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class MProject: Model {
    
    var pPj_id:NSString!
    var pPj_name:NSString!
    var pPj_description:NSString!
    var pPj_db_ref:NSString!
    var pPj_image:NSString!
    var pActive:NSString!

    
    override init() {
        
    }
    required init(coder aDecoder: NSCoder) {
        self.pPj_id  = aDecoder.decodeObjectForKey("pPj_id") as? NSString
        self.pPj_name  = aDecoder.decodeObjectForKey("pPj_name") as? NSString
        self.pPj_description  = aDecoder.decodeObjectForKey("pPj_description") as? NSString
        self.pPj_db_ref  = aDecoder.decodeObjectForKey("pPj_db_ref") as? NSString
        self.pPj_image  = aDecoder.decodeObjectForKey("pPj_image") as? NSString
        self.pActive  = aDecoder.decodeObjectForKey("pActive") as? NSString
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let val = self.pPj_id{
            aCoder.encodeObject(val, forKey: "pPj_id")
        }
        if let val = self.pPj_name{
            aCoder.encodeObject(val, forKey: "pPj_name")
        }
        if let val = self.pPj_description{
            aCoder.encodeObject(val, forKey: "pPj_description")
        }
        if let val = self.pPj_db_ref{
            aCoder.encodeObject(val, forKey: "pPj_db_ref")
        }
        if let val = self.pPj_image{
            aCoder.encodeObject(val, forKey: "pPj_image")
        }
        if let val = self.pActive{
            aCoder.encodeObject(val, forKey: "pActive")
        }
    }
   
}
