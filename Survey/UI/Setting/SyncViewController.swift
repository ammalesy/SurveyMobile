//
//  SyncViewController.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/14/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit
import SCLAlertView

class SyncViewController: UIViewController {

    @IBOutlet weak var versionLB: UILabel!
    @IBOutlet weak var lastUpdateSendSurveyLB: UILabel!
    @IBOutlet weak var lastUpdateUpdateSurveyLB: UILabel!
    @IBAction func sendSurveyAction(sender: AnyObject) {
        
        MSync.syncToServer({ (message) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                AlertUtil.showAlertSuccess("Success", detail: message, completion: { () -> Void! in
                    print(message)
                })
                
                self.lastUpdateSendSurveyLB.text =  DateUtil.dateFormater().stringFromDate(NSDate())
                CachingControl.setCacheDynamicKey(KEY_SEND_SURVEYS, data: self.lastUpdateUpdateSurveyLB.text)
                CachingControl.clearCache(CachingIdentifier.SurVeyResultList)
            })
        }, failur: { (message) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                AlertUtil.showAlertError("Sorry", detail: message)
                
                self.lastUpdateUpdateSurveyLB.text =  DateUtil.dateFormater().stringFromDate(NSDate())
                CachingControl.setCacheDynamicKey(KEY_UPDATE_SURVEYS, data: self.lastUpdateUpdateSurveyLB.text)
            })
        })
        
    }
    @IBAction func updateSurveysAction(sender: AnyObject) {
        
        let loading:SCLAlertView =  AlertUtil.showWaiting()
        MSurvey.get_surveys({ (surveys) -> Void in
            loading.hideView()
            
            CachingControl.getCache(CachingIdentifier.Survey, retriveCacheSuccess: { (cacheSurveys) -> Void in
                
                for(var index = 0; index < surveys.count; index++){
                    let serverSurvey:MSurvey = surveys[index] as! MSurvey
                    for(var i = 0; i < cacheSurveys.count; i++){
                        let cacheSurvey:MSurvey = cacheSurveys[i] as! MSurvey
                        if(cacheSurvey.pSm_id == serverSurvey.pSm_id){
                            serverSurvey.pCountUser = cacheSurvey.pCountUser
                        }
                    }
                }
                CachingControl.clearCache(CachingIdentifier.Survey)
                CachingControl.setCache(CachingIdentifier.Survey, data: surveys)
            }, neverStore: { () -> Void in
                
            })
            
            
        }, failure: { (errorMessage) -> Void in
            loading.hideView()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                AlertUtil.showAlertError("Sorry", detail: errorMessage)
            })
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Setting"
        //self.sideMenuController()?.sideMenu?.delegate = self
        
        self.versionLB.text = "  Version \(VERSION)"
        
        CachingControl.getCacheDynamicKey(KEY_SEND_SURVEYS, retriveCacheSuccess: { (timeString) -> Void in
            self.lastUpdateSendSurveyLB.text = timeString as? String
        }) { () -> Void in
            self.lastUpdateSendSurveyLB.text = "This device never sends data to server."
        }
        
        CachingControl.getCacheDynamicKey(KEY_UPDATE_SURVEYS, retriveCacheSuccess: { (timeString) -> Void in
            self.lastUpdateUpdateSurveyLB.text = timeString as? String
        }) { () -> Void in
            self.lastUpdateUpdateSurveyLB.text = "No surveys content in this device."
        }
        
        self.navigationItem.prompt = String(Session.sharedInstance.a_name)
        
        
        
        /*======== LEFT BAR BUTTON ITEM ==========*/
        let menuBarButton:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_66"), style: UIBarButtonItemStyle.Plain, target: self, action: "toggleSideMenu")
        menuBarButton.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = menuBarButton
        /*======== RIGHT BAR BUTTON ITEM ==========*/
        let listProjectBarButton:UIBarButtonItem = UIBarButtonItem(title: "List project", style: UIBarButtonItemStyle.Plain, target: self, action: "goToListProject:")
        listProjectBarButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = listProjectBarButton
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.toggleSideMenu()
//        var logo:UIImage = UIImage(named: "logo_survey")!
//        self.navigationItem.titleView = UIImageView(image: logo)
    }
    func toggleSideMenu(){
        self.splitViewController?.toggleMasterView()
    }
    func goToListProject(sender: AnyObject){
        AppDelegate.getDelegate().surveys.removeAllObjects()
        self.splitViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
