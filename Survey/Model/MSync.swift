//
//  MSync.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/18/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView

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
        
        let sync:MSync = MSync()
        sync.pU_firstname = user.pU_firstname
        sync.pU_surname = user.pU_surname
        sync.pSm_id_ref = survey.pSm_id
        sync.pH_timestamp = DateUtil.dateFormater().stringFromDate(NSDate())
        sync.pU_sex = String(user.pU_sex)
        sync.pU_age = String(user.pU_age)
        sync.pU_email = user.pU_email
        sync.pU_tel = user.pU_tel
        
        var resultConvert:NSMutableDictionary = NSMutableDictionary()
        for(var i = 0; i < survey.pQuestions.count; i++){
            
            var theKey = "q_\((survey.pQuestions[i] as! MQuestion).pAq_id)"
            
            var listAnswer:NSMutableArray = (survey.pQuestions[i] as! MQuestion).pAnswers
            var ansConvert:NSString = ""
            
            var listAns:NSMutableArray = NSMutableArray()
            for ans:MAnswer in listAnswer as Array as! [MAnswer] {
                if (ans.pChecked == true) {
                    
                    if(ans.pAnswerStyle.pAs_identifier.isEqualToString(CHECKBOX_IDENTIFIER)){
                        listAns.addObject(["aa_id":ans.pAa_id])
                    }else if(ans.pAnswerStyle.pAs_identifier.isEqualToString(TEXTBOX_IDENTIFIER) ||
                             ans.pAnswerStyle.pAs_identifier.isEqualToString(CHECKBOX_TEXTBOX_IDENTIFIER) ||
                             ans.pAnswerStyle.pAs_identifier.isEqualToString(RADIO_TEXTBOX_IDENTIFIER))
                    {
                        listAns.addObject(["aa_id":ans.pAa_id,
                                            "text":ans.pTextFromTxtBox])
                    }else{
                        listAns.addObject(["aa_id":ans.pAa_id])
                    }
                    
                    //ansConvert = ansConvert.stringByAppendingString(",\(ans.pAa_id)")
                }
            }
//            if(ansConvert != "") {
//                ansConvert = ansConvert.substringFromIndex(1)
//            }
            let data = NSJSONSerialization.dataWithJSONObject(listAns, options: nil, error: nil)
            let jsonString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            println(jsonString!)
            resultConvert.setValue(jsonString, forKey: theKey)
        }
        sync.pResult = resultConvert
        
        return sync
        
    }
    func toJson() -> AnyObject!{
        
        var json:NSMutableDictionary = NSMutableDictionary()
        json.setObject(self.pU_firstname, forKey: "u_firstname")
        json.setObject(self.pU_surname, forKey: "u_surname")
        json.setObject(self.pSm_id_ref, forKey: "sm_id_ref")
        json.setObject(self.pH_timestamp, forKey: "h_timestamp")
        json.setObject(self.pU_sex, forKey: "u_sex")
        json.setObject(self.pU_age, forKey: "u_age")
        json.setObject(self.pU_email, forKey: "u_email")
        json.setObject(self.pU_tel, forKey: "u_tel")
        json.setObject(self.pResult, forKey: "result")
        return json
        
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
    class func syncToServer(success: (message:NSString!) -> Void, failur: (message:NSString!) -> Void){
        
        CachingControl.getCache(CachingIdentifier.SurVeyResultList, retriveCacheSuccess: { (listCache) -> Void in
            
            var param:NSMutableArray = NSMutableArray()
            for sync:MSync in listCache as! Array as [MSync] {
                param.addObject(sync.toJson())
            }
            let postParam = ["data":param,"project_name":Session.sharedInstance.project_selected]
            Alamofire.request(.POST,
                "\(Model.basePath.url)/SyncDataManager/sync",
                parameters: postParam,
                encoding:ParameterEncoding.JSON)
                .responseString { _, _, string, _ in
                    
                    println(string)
                    
                }.responseJSON { _, response, JSON, _ in
                    
                    if(response!.statusCode == 200){
                        success(message: "Sync data complete")
                    }else{
                        failur(message: "Sync data fail!")
                    }
                    
            }
            
        }) { () -> Void in
            failur(message: "Surveys not found on this device.")
        }
    }
   
}
