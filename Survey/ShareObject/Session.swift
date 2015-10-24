//
//  Session.swift
//  Survey
//
//  Created by Apple on 10/17/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView

class Session: NSObject {
    static let sharedInstance = Session()
    
    var a_id:NSString!
    var a_user:NSString!
    var a_name:NSString!
    var isLogin:Bool = false
    
    //associate
    var project_selected:NSString!
    var project_name_selected:NSString!
    var last_login:NSString!
    
    override init(){
        super.init()
        
    }
    func clear(){
    
        CachingControl.clearCache(CachingIdentifier.Session)
        self.a_id = ""
        self.a_user = ""
        self.a_name = ""
        self.last_login = ""
        self.isLogin = false
        
        Project.sharedInstance.clear()
        
    }
    
    func login(a_user:NSString!, a_pass:NSString!,success: (session:Session) -> Void, failur: () -> Void){
        
        let alert:SCLAlertView =  AlertUtil.showWaiting(0.0,text:"Connecting...")
        
        print(a_user)
        print(a_pass)
        
        Alamofire.request(.POST, "\(Model.basePath.url)/AdminManagement/admin", parameters: ["a_user":a_user,"a_pass":a_pass])
            .responseJSON { response in
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    let json:NSMutableDictionary = JSON as! NSMutableDictionary
                    
                    alert.hideView()
                    
                    if(response.response!.statusCode == 200){
                        
                        self.a_id = json.objectForKey("a_id") as! NSString
                        self.a_name = json.objectForKey("a_name") as! NSString
                        self.a_user = json.objectForKey("a_user") as! NSString
                        self.last_login = DateUtil.dateFormater().stringFromDate(NSDate())
                        self.isLogin = true
                        
                        
                        let dummyArray:NSMutableArray = NSMutableArray()
                        let dummyDict:NSMutableDictionary = NSMutableDictionary()
                        dummyDict.setObject(self.a_id, forKey: "a_id")
                        dummyDict.setObject(self.a_name, forKey: "a_name")
                        dummyDict.setObject(self.a_user, forKey: "a_user")
                        dummyDict.setObject(self.last_login, forKey: "last_login")
                        dummyArray.addObject(dummyDict)
                        CachingControl.setCache(CachingIdentifier.Session, data:dummyArray )
                        
                        success(session: self)
                    }else{
                        failur()
                    }
                }
        }
        /////
        
//        Alamofire.request(.POST,
//            "\(Model.basePath.url)/AdminManagement/admin",
//            parameters: ["a_user":a_user,"a_pass":a_pass],
//            encoding:ParameterEncoding.JSON)
//            .responseString { _, _, string, _ in
//                
//                println(string)
//                
//            }.responseJSON { _, response, JSON, _ in
//                
//                
//                
//        }
    }
    
    func getProject(success: (project:Project) -> Void, failur: () -> Void){
        let alert:SCLAlertView =  AlertUtil.showWaiting(0.0,text:"Waiting ...")
        
        
        Alamofire.request(.GET, "\(Model.basePath.url)/OwnerManagement/owner/\(self.a_id)", parameters: nil)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    let json:NSMutableArray = JSON as! NSMutableArray
                    let projectObject:Project = Project.sharedInstance;
                    
                    for(var index = 0; index < json.count; index++){
                        
                        let project:MProject = MProject()
                        project.pPj_id = (json[index].objectForKey("project") as! NSDictionary).objectForKey("pj_id") as! NSString
                        project.pPj_name = (json[index].objectForKey("project") as! NSDictionary).objectForKey("pj_name") as! NSString
                        project.pPj_description = (json[index].objectForKey("project") as! NSDictionary).objectForKey("pj_description") as! NSString
                        project.pPj_db_ref = (json[index].objectForKey("project") as! NSDictionary).objectForKey("pj_db_ref") as! NSString
                        project.pPj_image = (json[index].objectForKey("project") as! NSDictionary).objectForKey("pj_image") as! NSString
                        project.pActive = (json[index].objectForKey("project") as! NSDictionary).objectForKey("active") as! NSString
                        
                        projectObject.listProject.addObject(project)
                        
                    }
                    
                    alert.hideView()
                    
                    if(response.response!.statusCode == 200){
                        
                        success(project: projectObject)
                        
                    }else{
                        failur()
                    }
                }
        }
        /////
//        Alamofire.request(.GET,
//            "\(Model.basePath.url)/OwnerManagement/owner/\(self.a_id)",
//            parameters: nil,
//            encoding:ParameterEncoding.JSON)
//            .responseString { _, _, string, _ in
//                
//                println(string)
//                
//            }.responseJSON { _, response, JSON, _ in
//                
//                
//                
//        }
    }

}
