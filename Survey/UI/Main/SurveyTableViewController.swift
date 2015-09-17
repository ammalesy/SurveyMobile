//
//  SurveyTableViewController.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/10/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit
import SCLAlertView

class SurveyTableViewController: UITableViewController,ENSideMenuDelegate {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    var surveys:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var logo:UIImage = UIImage(named: "logo_survey")!
        self.navigationItem.titleView = UIImageView(image: logo)
        self.sideMenuController()?.sideMenu?.delegate = self
        
        self.syncQuestionFromServer { () -> Void in
            
        }
        
        self.refreshControl?.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl?.tintColor = ColorUtil.blueSky()
       
    }
    func syncQuestionFromServer(completionHandler:()->Void){
        surveys = NSMutableArray()
        
        CachingControl.getCache(CachingIdentifier.Survey, retriveCacheSuccess: { (cachingArray) -> Void in
            
            self.surveys = cachingArray as! NSMutableArray
            self.tableView.reloadData()
            completionHandler()
            
        }) { () -> Void in
                var loadingView:SCLAlertView =  AlertUtil.showWaiting()
                MSurvey.get_surveys({ (surveys) -> Void in
                    loadingView.hideView()
                    self.surveys = surveys
                    CachingControl.setCache(CachingIdentifier.Survey, data: surveys)
                    self.tableView.reloadData()
                    self.removeErrorLabelAtTable()
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
        var lb:UILabel = UILabel(frame: CGRectMake((self.tableView.frame.size.width / 2) - 160, 30, 320, 60))
        
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
        toggleSideMenuView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return surveys.count;
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
        var view:UILabel = UILabel()
        view.backgroundColor = UIColor.whiteColor()//UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        view.text = "  All survey (\(surveys.count))"
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
        
        var survey:MSurvey = surveys.objectAtIndex(indexPath.row) as! MSurvey
        AlertUtil.showInformation { (nameTxt, surnameTxt, ageTxt, emailTxt, sexSeg) -> Void in
      
//            if( nameTxt.text != "" &&
//                surnameTxt.text != "" &&
//                ageTxt.text != "" &&
//                emailTxt.text != "" )
//            {
                var user:MUser = MUser()
                user.pU_firstname = "\(nameTxt.text) \(surnameTxt.text)"
                user.pU_age = ageTxt.text.toInt()
                user.pU_email = emailTxt.text
                var sb = UIStoryboard(name: "Main",bundle: nil);
                var controller:MainSurveyViewController = sb.instantiateViewControllerWithIdentifier("MainSurveyViewController") as! MainSurveyViewController
                controller.user = user
                controller.survey = survey
                self.navigationController?.pushViewController(controller, animated: true)
            //}
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SurveyTableViewCell
        var survey:MSurvey = surveys.objectAtIndex(indexPath.row) as! MSurvey
        cell.pTitle.text = survey.pSm_name as String
        cell.pDescription.text = survey.pSm_description as String
        cell.pAmount.text = String(survey.pCountUser)
        cell.lb_seq.text = String(indexPath.row + 1)
        cell.selectedBackgroundView = UIView()

        return cell
    }
}
