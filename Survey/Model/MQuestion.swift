//
//  MQuestion.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/14/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

class MQuestion: Model,NSCoding,NSCopying {
    var pAq_id:NSString!
    var pAq_description:NSString!
    var pActive:NSString!
    
    //associate
    var pAnswers:NSMutableArray!
   
    func copyWithZone(zone: NSZone) -> AnyObject {
        let obj:MQuestion = MQuestion()
        obj.pAq_id = self.pAq_id
        obj.pAq_description = self.pAq_description
        obj.pActive = self.pActive
        obj.pAnswers = self.pAnswers
        return obj
    }
    
    override init() {}
    required init(coder aDecoder: NSCoder) {
        self.pAq_id  = aDecoder.decodeObjectForKey("pAq_id") as? NSString
        self.pAq_description  = aDecoder.decodeObjectForKey("pAq_description") as? NSString
        self.pActive  = aDecoder.decodeObjectForKey("pActive") as? NSString
        self.pAnswers  = aDecoder.decodeObjectForKey("pAnswers") as? NSMutableArray
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let val = self.pAq_id{
            aCoder.encodeObject(val, forKey: "pAq_id")
        }
        if let val = self.pAq_description{
            aCoder.encodeObject(val, forKey: "pAq_description")
        }
        if let val = self.pActive{
            aCoder.encodeObject(val, forKey: "pActive")
        }
        if let val = self.pAnswers{
            aCoder.encodeObject(val, forKey: "pAnswers")
        }
    }
}
