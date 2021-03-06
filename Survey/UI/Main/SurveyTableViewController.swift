//
//  SurveyTableViewController.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/10/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit
import SCLAlertView

class SurveyTableViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
   
    var listTxtOnInforPanel:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let logo:UIImage = UIImage(named: "logo_survey")!
        self.navigationItem.titleView = UIImageView(image: logo)
        //self.sideMenuController()?.sideMenu?.delegate = self
        
        self.syncQuestionFromServer { () -> Void in
            
        }
        
        self.refreshControl?.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl?.tintColor = ColorUtil.blueSky()
        
        
       
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    func syncQuestionFromServer(completionHandler:()->Void){
        AppDelegate.getDelegate().surveys = NSMutableArray()
        
        CachingControl.getCache(CachingIdentifier.Survey, retriveCacheSuccess: { (cachingArray) -> Void in
            
            AppDelegate.getDelegate().surveys = cachingArray as! NSMutableArray
            self.tableView.reloadData()
            completionHandler()
            
        }) { () -> Void in
                let loadingView:SCLAlertView =  AlertUtil.showWaiting()
                MSurvey.get_surveys({ (surveys) -> Void in
                    loadingView.hideView()
                    AppDelegate.getDelegate().surveys = surveys
                    CachingControl.setCache(CachingIdentifier.Survey, data: surveys)
                    self.tableView.reloadData()
                    self.removeErrorLabelAtTable()
                    
                    CachingControl.setCacheDynamicKey(KEY_UPDATE_SURVEYS, data: DateUtil.dateFormater().stringFromDate(NSDate()))
                    completionHandler()
                    
                }, failure: { (errorString) -> Void in
                    loadingView.hideView()
                        
                    AlertUtil.showAlertError("Network error.", detail: errorString)
                        
                    self.tableView.reloadData()
                    self.addErrorLabelToTable(errorString)
                    completionHandler()
                })
        }
    }
    func addErrorLabelToTable(string:NSString!){
        self.removeErrorLabelAtTable()
        let lb:UILabel = UILabel(frame: CGRectMake((self.tableView.frame.size.width / 2) - 160, 30, 320, 60))
        
        lb.textColor = ColorUtil.blueSky()
        lb.text = String(string)
        lb.textAlignment = NSTextAlignment.Center
        lb.tag = 1000
        self.tableView.addSubview(lb)
    }
    func removeErrorLabelAtTable(){
        if let lb:UILabel = self.tableView.viewWithTag(1000) as? UILabel {
            lb.removeFromSuperview()
        }
        
    }
    
    func refreshData() {
        self.syncQuestionFromServer { () -> Void in
            self.refreshControl?.endRefreshing()
        }
        
    }
    
    @IBAction func openLeftPanel(sender: AnyObject)
    {
        //toggleSideMenuView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return AppDelegate.getDelegate().surveys.count;
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //if(UIDevice.currentDevice().userInterfaceIdiom == .Pad){
            if(indexPath.row == 0){
                return 130
            }
        //}
        return 120
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UILabel = UILabel()
        view.backgroundColor = UIColor.whiteColor()//UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        view.text = "  All survey (\(AppDelegate.getDelegate().surveys.count))"
        view.textColor = UIColor(red: 94/255.0, green: 190/255.0, blue: 202/255.0, alpha: 1)
        view.font = UIFont.boldSystemFontOfSize(14)
        return view
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
        
        if(indexPath.row == 0){
            (cell as! SurveyTableViewCell).ct_top_contentView.constant = 10
        }else{
            (cell as! SurveyTableViewCell).ct_top_contentView.constant = 0
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let survey:MSurvey = AppDelegate.getDelegate().surveys.objectAtIndex(indexPath.row) as! MSurvey
        
        let returnObj = AlertUtil.showInformation { (nameTxt, surnameTxt, ageTxt,telTxt, emailTxt, sexSeg) -> Void in
            
            if( nameTxt.text != "" && surnameTxt.text != "" )
            {
                if(ageTxt.text == nil || ageTxt.text == "") {ageTxt.text = "0"}
                let user:MUser = MUser()
                user.pU_firstname = nameTxt.text
                user.pU_surname = surnameTxt.text
                user.pU_age = Int(ageTxt.text!)
                user.pU_sex = sexSeg.selectedSegmentIndex
                user.pU_email = emailTxt.text
                user.pU_tel = telTxt.text
                let sb = UIStoryboard(name: "Main",bundle: nil);
                let controller:MainSurveyViewController = sb.instantiateViewControllerWithIdentifier("MainSurveyViewController") as! MainSurveyViewController
                controller.user = user
                controller.survey = survey.copy() as! MSurvey
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
        var listTxt =  returnObj.textFields
        listTxt[0].delegate = self
        listTxt[1].delegate = self
        listTxt[2].delegate = self
        listTxt[3].delegate = self
        listTxt[4].delegate = self
        
        listTxt[0].addTarget(self, action: "textChange:", forControlEvents: UIControlEvents.EditingChanged)
        listTxt[1].addTarget(self, action: "textChange:", forControlEvents: UIControlEvents.EditingChanged)
        listTxt[2].addTarget(self, action: "textChange:", forControlEvents: UIControlEvents.EditingChanged)
        listTxt[3].addTarget(self, action: "textChange:", forControlEvents: UIControlEvents.EditingChanged)
        listTxt[4].addTarget(self, action: "textChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        self.listTxtOnInforPanel = listTxt
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if(textField.tag != 999) {
            textField.inputAccessoryView = nil
            
            let containerView:UIView = UIView(frame: CGRectMake(0, 0, 0, 30))
            containerView.backgroundColor = ColorUtil.blueSky()
            
            let tempTxtField:KBUITextField = KBUITextField(frame: CGRectMake(10, 0, UIScreen.mainScreen().bounds.width - 20, 30))
            tempTxtField.backgroundColor = ColorUtil.blueSky()
            tempTxtField.borderStyle = UITextBorderStyle.None
            tempTxtField.placeholder = textField.placeholder
            tempTxtField.textColor = UIColor.whiteColor()
            tempTxtField.tag = 999
            tempTxtField.delegate = self
            tempTxtField.ref = textField.tag
            tempTxtField.addTarget(self, action: "textChange:", forControlEvents: UIControlEvents.EditingChanged)
            
            containerView.addSubview(tempTxtField)
            textField.inputAccessoryView = containerView
            
            tempTxtField.text = textField.text
        }
        
    }
    func textChange(textfield:UITextField!) {

        if(textfield.tag != 999){
            
            let accTxt = textfield.inputAccessoryView!.viewWithTag(999) as! UITextField
            accTxt.text = textfield.text
        
        }else{

            (listTxtOnInforPanel[(textfield as! KBUITextField).ref] as! UITextField).text = textfield.text
            
        }
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SurveyTableViewCell
        let survey:MSurvey = AppDelegate.getDelegate().surveys.objectAtIndex(indexPath.row) as! MSurvey
        cell.pTitle.text = survey.pSm_name as String
        cell.pDescription.text = survey.pSm_description as String
        cell.pAmount.text = String(survey.pCountUser)
        cell.lb_seq.text = String(indexPath.row + 1)
        cell.selectedBackgroundView = UIView()

        return cell
    }
}
