//
//  AlertUtil.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/15/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit
import SCLAlertView

class AlertUtil: NSObject {
    class func showAlertError(title:NSString!,detail:NSString!) -> (SCLAlertView!) {
        var alert:SCLAlertView = SCLAlertView()
        alert.showError(String(title), subTitle: String(detail),colorStyle: 0x52c2d1, colorTextButton: 0xFFFFFF)
        return alert
    }
    class func showWaiting(duration:NSTimeInterval?=0.0) -> (SCLAlertView!) {
        var loadingView:SCLAlertView =  SCLAlertView()
        loadingView.showCloseButton = false
        
        if(duration > 0.0){
            loadingView.showWait("SyncData", subTitle: "wainting for question data..", duration:duration! ,colorStyle: 0x52c2d1)
        }else{
            loadingView.showWait("SyncData", subTitle: "wainting for question data..", colorStyle: 0x52c2d1)
        }
        return loadingView
    }
    class func showInformation(pressedConfirm: (nameTxt:UITextField!,surnameTxt:UITextField!,ageTxt:UITextField!,emailTxt:UITextField!,sexSeg:UISegmentedControl!) -> Void) -> (SCLAlertView!){
       
        let alert = SCLAlertView()

        let name = alert.addTextField(title:"Enter your firstname")
        let surname = alert.addTextField(title:"Enter your surname")
        let age = alert.addTextField(title:"Enter your age")
        let email = alert.addTextField(title:"Enter your email")
        let sexTxt = alert.addTextField(title: "")
        
        var segmentSex = UISegmentedControl(items: ["Male","Female"])
        segmentSex.selectedSegmentIndex = 0
        segmentSex.tintColor = ColorUtil.blueSky()
        segmentSex.frame = CGRectMake(12, 281, 216, 35)
        sexTxt.superview!.addSubview(segmentSex)
        sexTxt.removeFromSuperview()
        
        
        alert.addButton("Confirm") { () -> Void in
            pressedConfirm(nameTxt: name, surnameTxt: surname, ageTxt: age, emailTxt: email, sexSeg: segmentSex)
        }
        
        alert.showEdit("Information.", subTitle: "Fill your information", closeButtonTitle: "Cancel", colorStyle:0x52c2d1, colorTextButton:0xFFFFFF)
        return alert as SCLAlertView!
    }
}
