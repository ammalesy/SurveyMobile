//
//  CachingControl.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/12/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

let KEY_SURVEYS_CACHE = "Surveys"
let KEY_SURVEYS_RESULT_LIST_CACHE = "SurVeyResultList"
let KEY_SEND_SURVEYS = "sendSurveyTimestamp"
let KEY_UPDATE_SURVEYS = "updateSurveyTimestamp"
let KEY_IMAGES_SURVEYS = "imagesSurveys"
let KEY_SESSION = "session"

enum CachingIdentifier : Int {
    
    case None
    case Survey
    case SurVeyResultList
    case SurveyImage
    case Session

}

var cachingImageOnMemory:NSMutableDictionary = NSMutableDictionary()
var cachingImagePJOnMemory:NSMutableDictionary = NSMutableDictionary()

class CachingControl: NSObject {
    
    class func getCache(identifier:CachingIdentifier, retriveCacheSuccess: (AnyObject!) -> Void , neverStore: () -> Void)
    {
        if(identifier == CachingIdentifier.Survey){
            if let surveyCache: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("\(KEY_SURVEYS_CACHE)_\(Session.sharedInstance.project_selected)") {
                let list = NSKeyedUnarchiver.unarchiveObjectWithData(surveyCache as! NSData) as? NSMutableArray

                retriveCacheSuccess(list)
            }else{
                neverStore()
            }
        }else if(identifier == CachingIdentifier.SurVeyResultList){
            if let resultListCache: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("\(KEY_SURVEYS_RESULT_LIST_CACHE)_\(Session.sharedInstance.project_selected)") {
                let list = NSKeyedUnarchiver.unarchiveObjectWithData(resultListCache as! NSData) as? NSMutableArray
                
                retriveCacheSuccess(list)
            }else{
                neverStore()
            }
        }else if(identifier == CachingIdentifier.SurveyImage){
            if let resultListCache: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(KEY_IMAGES_SURVEYS) {
                let list = NSKeyedUnarchiver.unarchiveObjectWithData(resultListCache as! NSData) as? NSMutableArray
                
                retriveCacheSuccess(list)
            }else{
                neverStore()
            }
        }else if(identifier == CachingIdentifier.Session){
            if let resultCache: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(KEY_SESSION) {
                
                print(resultCache)
                
                let list:NSArray = (NSKeyedUnarchiver.unarchiveObjectWithData(resultCache as! NSData) as? NSMutableArray)!
                //println("dict =\(list[0])")
                
                retriveCacheSuccess(list[0])
            }else{
                neverStore()
            }
        }else{
            neverStore()
        }
    }
    class func setCache(identifier:CachingIdentifier, data:AnyObject!)->(Bool) {
        if(identifier == CachingIdentifier.Survey)
        {
            let archiver = NSKeyedArchiver.archivedDataWithRootObject(data)
            NSUserDefaults.standardUserDefaults().setObject(archiver, forKey: "\(KEY_SURVEYS_CACHE)_\(Session.sharedInstance.project_selected)")
            return NSUserDefaults.standardUserDefaults().synchronize()
        }
        else if(identifier == CachingIdentifier.SurVeyResultList)
        {
            let archiver = NSKeyedArchiver.archivedDataWithRootObject(data)
            NSUserDefaults.standardUserDefaults().setObject(archiver, forKey: "\(KEY_SURVEYS_RESULT_LIST_CACHE)_\(Session.sharedInstance.project_selected)")
            return NSUserDefaults.standardUserDefaults().synchronize()
        }
        else if(identifier == CachingIdentifier.SurveyImage)
        {
            let archiver = NSKeyedArchiver.archivedDataWithRootObject(data)
            NSUserDefaults.standardUserDefaults().setObject(archiver, forKey: KEY_IMAGES_SURVEYS)
            return NSUserDefaults.standardUserDefaults().synchronize()
        }
        else if(identifier == CachingIdentifier.Session)
        {
            let archiver = NSKeyedArchiver.archivedDataWithRootObject(data)
            NSUserDefaults.standardUserDefaults().setObject(archiver, forKey: KEY_SESSION)
            return NSUserDefaults.standardUserDefaults().synchronize()
        }
        else
        {
            return false
        }
    }
    class func clearCache(identifier:CachingIdentifier) {
        if(identifier == CachingIdentifier.Survey){
           
            NSUserDefaults.standardUserDefaults().removeObjectForKey("\(KEY_SURVEYS_CACHE)_\(Session.sharedInstance.project_selected)")

        }else if(identifier == CachingIdentifier.SurVeyResultList){
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey("\(KEY_SURVEYS_RESULT_LIST_CACHE)_\(Session.sharedInstance.project_selected)")
            
        }else if(identifier == CachingIdentifier.SurveyImage){
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey(KEY_IMAGES_SURVEYS)
            
        }else if(identifier == CachingIdentifier.Session){
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey(KEY_SESSION)
            
        }
    }
    
    //////
    //////
    class func clearCacheDynamicKey(key:NSString, retriveCacheSuccess: (AnyObject!) -> Void , neverStoreData neverStore: () -> Void){
        
        if let cache: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(key as String) {
            let list: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(cache as! NSData)
            retriveCacheSuccess(list)
        }else{
            neverStore()
        }

    }
    class func setCacheDynamicKey(key:NSString, data:AnyObject!)->(Bool) {
    
        let archiver = NSKeyedArchiver.archivedDataWithRootObject(data)
        NSUserDefaults.standardUserDefaults().setObject(archiver, forKey: key as String)
        return NSUserDefaults.standardUserDefaults().synchronize()
    }
    class func getCacheDynamicKey(key:NSString, retriveCacheSuccess: (AnyObject!) -> Void , neverStore: () -> Void) {
        
        if let cache: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(key as String) {
            retriveCacheSuccess(NSKeyedUnarchiver.unarchiveObjectWithData(cache as! NSData))
        }else{
            neverStore()
        }
        
    }
}
