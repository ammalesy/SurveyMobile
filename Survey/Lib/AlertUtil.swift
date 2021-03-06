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
        let alert:SCLAlertView = SCLAlertView()
        alert.showError(String(title), subTitle: String(detail),colorStyle: 0xeb6f3b, colorTextButton: 0xFFFFFF)
        return alert
    }
    class func showAlertSuccess(title:NSString!,detail:NSString!,completion:()->Void!) -> (SCLAlertView!) {
        let alert:SCLAlertView = SCLAlertView()
        alert.showCloseButton = false
        alert.addButton("Done", action: { () -> Void in
            completion()
        })
        alert.showSuccess(String(title), subTitle: String(detail),colorStyle: 0xeb6f3b, colorTextButton: 0xFFFFFF)
        return alert
    }
    class func showWaiting(duration:NSTimeInterval?=0.0, text:String?="wainting for question data..") -> (SCLAlertView!) {
        let loadingView:SCLAlertView =  SCLAlertView()
        loadingView.showCloseButton = false
        
        if(duration > 0.0){
            loadingView.showWait("SyncData", subTitle: text!, duration:duration! ,colorStyle: 0xeb6f3b)
        }else{
            loadingView.showWait("SyncData", subTitle: text!, colorStyle: 0xeb6f3b)
        }
        return loadingView
    }
    class func showInformation(pressedConfirm: (nameTxt:UITextField!,surnameTxt:UITextField!,ageTxt:UITextField!,
        telTxt:UITextField!, emailTxt:UITextField!,sexSeg:UISegmentedControl!) -> Void) -> (alertView:SCLAlertView!,textFields:[UITextField!]){
       
        let alert = SCLAlertView()

        let name = alert.addTextField("Enter your firstname")
        let surname = alert.addTextField("Enter your surname")
        let age = alert.addTextField("Enter your age")
        let tel = alert.addTextField("Enter your Tel.")
        let email = alert.addTextField("Enter your email")
        let sexTxt = alert.addTextField("")
            
        name.tag = 0
        surname.tag = 1
        age.tag = 2
        tel.tag = 3
        email.tag = 4
            
        age.keyboardType = UIKeyboardType.NumberPad
        
        let segmentSex = UISegmentedControl(items: ["Male","Female"])
        segmentSex.selectedSegmentIndex = 0
        segmentSex.tintColor = ColorUtil.blueSky()
        segmentSex.frame = CGRectMake(12, 325, 216, 35)
        sexTxt.superview!.addSubview(segmentSex)
        sexTxt.removeFromSuperview()
        
        
        alert.addButton("Confirm") { () -> Void in
            pressedConfirm(nameTxt: name, surnameTxt: surname, ageTxt: age, telTxt:tel, emailTxt: email, sexSeg: segmentSex)
        }
        
        alert.showEdit("Information.", subTitle: "Fill your information", closeButtonTitle: "Cancel", colorStyle:0xeb6f3b, colorTextButton:0xFFFFFF)
            return (alert as SCLAlertView!,[name,surname,age,tel,email,sexTxt])
    }
}
