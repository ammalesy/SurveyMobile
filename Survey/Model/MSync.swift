//
//  MSync.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/18/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

class MSync: Model,NSCoding {
    
    var pU_firstname:NSString!
    var pU_surname:NSString!
    var pSm_id_ref:NSString!
    var pH_timestamp:NSString!
    var pU_sex:NSString!
    var pU_age:NSString!
    var pU_email:NSString!
    var pU_tel:NSString!
    var pResult:NSMutableDictionary!
    
    override init() {}
    required init(coder aDecoder: NSCoder) {
        self.pU_firstname  = aDecoder.decodeObjectForKey("pU_firstname") as? NSString
        self.pU_surname  = aDecoder.decodeObjectForKey("pU_surname") as? NSString
        self.pSm_id_ref  = aDecoder.decodeObjectForKey("pSm_id_ref") as? NSString
        self.pH_timestamp  = aDecoder.decodeObjectForKey("pH_timestamp") as? NSString
        self.pU_sex  = aDecoder.decodeObjectForKey("pU_sex") as? NSString
        self.pU_age  = aDecoder.decodeObjectForKey("pU_age") as? NSString
        self.pU_email  = aDecoder.decodeObjectForKey("pU_email") as? NSString
        self.pU_tel  = aDecoder.decodeObjectForKey("pU_tel") as? NSString
        self.pResult  = aDecoder.decodeObjectForKey("pResult") as? NSMutableDictionary
    }
    class func convertToSyncFormat(survey:MSurvey! , user:MUser!)->MSync {
        
        //        let user =  [
        //            "u_firstname":"Ammales",
        //            "u_surname":"Yamsompong",
        //            "sm_id_ref":"10",
        //            "h_timestamp":"2015-05-09 11:20:10",
        //            "u_sex":"",
        //            "u_age":"",
        //            "u_email":"",
        //            "u_tel":"",
        //            "result":[
        //                "q_12":"97",
        //                "q_1":"102",
        //                "q_13":"110",
        //                "q_14":"129"
        //            ]
        //        ]
        let sync:MSync = MSync()
        sync.pU_firstname = user.pU_firstname
        sync.pU_surname = user.pU_surname
        sync.pSm_id_ref = survey.pSm_id
        
        let formatDate:NSDateFormatter = NSDateFormatter()
        formatDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        sync.pH_timestamp = formatDate.stringFromDate(NSDate())
        sync.pU_sex = String(user.pU_sex)
        sync.pU_age = String(user.pU_age)
        sync.pU_email = user.pU_email
        sync.pU_tel = user.pU_tel
        
        for(var i = 0; i < survey.pQuestions.count; i++){
            var resultConvert:NSMutableArray = NSMutableArray()
            var theKey = "q_\((survey.pQuestions[i] as! MQuestion).pAq_id)"
            
            
            var listAnswer:NSMutableArray = (survey.pQuestions[i] as! MQuestion).pAnswers
            var ansConvert:NSMutableDictionary = NSMutableDictionary()
//            for(var j = 0; j < listAnswer.count; j++) {
//                var ans:MAnswer = listAnswer[i] as! MAnswer
//                if (ans.pChecked == true) {
//                    ansConvert.setObject(ans.pAa_id, forKey: "\(ans.pAa_id)")
//                }
//            }
        }
        
        
    }
    func toJson() -> AnyObject!{
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        return NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
    }
    func encodeWithCoder(aCoder: NSCoder) {
        if let val = self.pU_firstname{
            aCoder.encodeObject(val, forKey: "pU_firstname")
        }
        if let val = self.pU_surname{
            aCoder.encodeObject(val, forKey: "pU_surname")
        }
        if let val = self.pSm_id_ref{
            aCoder.encodeObject(val, forKey: "pSm_id_ref")
        }
        if let val = self.pH_timestamp{
            aCoder.encodeObject(val, forKey: "pH_timestamp")
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
        if let val = self.pU_tel{
            aCoder.encodeObject(val, forKey: "pU_tel")
        }
        if let val = self.pResult{
            aCoder.encodeObject(val, forKey: "pResult")
        }
    }
   
}
