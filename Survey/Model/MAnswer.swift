//
//  MAnswer.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/14/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

class MAnswer: Model,NSCoding,NSCopying {
    
    var pAa_id:NSString!
    var pAa_description:NSString!
    var pAa_image:NSString?
    var pAq_id_ref:NSString!
    var pType:NSString!
    var pActive:NSString!
    var pChecked:Bool = false
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let obj:MAnswer = MAnswer()
        obj.pAa_id = self.pAa_id
        obj.pAa_description = self.pAa_description
        obj.pAa_image = self.pAa_image
        obj.pAq_id_ref = self.pAq_id_ref
        obj.pType = self.pType
        obj.pActive = self.pActive
        obj.pChecked = self.pChecked
        return obj
    }
    
    override init() {}
    required init(coder aDecoder: NSCoder) {
        self.pAa_id  = aDecoder.decodeObjectForKey("pAa_id") as? NSString
        self.pAa_description  = aDecoder.decodeObjectForKey("pAa_description") as? NSString
        self.pAa_image  = aDecoder.decodeObjectForKey("pAa_image") as? NSString
        self.pAq_id_ref  = aDecoder.decodeObjectForKey("pAq_id_ref") as? NSString
        self.pType  = aDecoder.decodeObjectForKey("pType") as? NSString
        self.pActive  = aDecoder.decodeObjectForKey("pActive") as? NSString
        self.pChecked  = (aDecoder.decodeObjectForKey("pChecked") as? Bool)!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let val = self.pAa_id{
            aCoder.encodeObject(val, forKey: "pAa_id")
        }
        if let val = self.pAa_description{
            aCoder.encodeObject(val, forKey: "pAa_description")
        }
        if let val = self.pAa_image{
            aCoder.encodeObject(val, forKey: "pAa_image")
        }
        if let val = self.pAq_id_ref{
            aCoder.encodeObject(val, forKey: "pAq_id_ref")
        }
        if let val = self.pType{
            aCoder.encodeObject(val, forKey: "pType")
        }
        if let val = self.pActive{
            aCoder.encodeObject(val, forKey: "pActive")
        }
        //if let val = self.pChecked{
            aCoder.encodeObject(self.pChecked, forKey: "pChecked")
        //}
    }
    
}
