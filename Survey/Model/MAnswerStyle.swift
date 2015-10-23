//
//  MAnswerStyle.swift
//  Survey
//
//  Created by Apple on 10/21/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class MAnswerStyle: Model,NSCoding,NSCopying  {

    
    var pAs_id:NSString!
    var pAs_name:NSString!
    var pAs_description:NSString!
    var pAs_text_color:NSString!
    var pAs_identifier:NSString!
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let obj:MAnswerStyle = MAnswerStyle()
        obj.pAs_id = self.pAs_id
        obj.pAs_name = self.pAs_name
        obj.pAs_description = self.pAs_description
        obj.pAs_text_color = self.pAs_text_color
        obj.pAs_identifier = self.pAs_identifier
        return obj
    }
    
    override init() {}
    required init(coder aDecoder: NSCoder) {
        self.pAs_id  = aDecoder.decodeObjectForKey("pAs_id") as? NSString
        self.pAs_name  = aDecoder.decodeObjectForKey("pAs_name") as? NSString
        self.pAs_description  = aDecoder.decodeObjectForKey("pAs_description") as? NSString
        self.pAs_text_color  = aDecoder.decodeObjectForKey("pAs_text_color") as? NSString
        self.pAs_identifier  = aDecoder.decodeObjectForKey("pAs_identifier") as? NSString
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let val = self.pAs_id{
            aCoder.encodeObject(val, forKey: "pAs_id")
        }
        if let val = self.pAs_name{
            aCoder.encodeObject(val, forKey: "pAs_name")
        }
        if let val = self.pAs_description{
            aCoder.encodeObject(val, forKey: "pAs_description")
        }
        if let val = self.pAs_text_color{
            aCoder.encodeObject(val, forKey: "pAs_text_color")
        }
        if let val = self.pAs_identifier{
            aCoder.encodeObject(val, forKey: "pAs_identifier")
        }
    }
   
}
