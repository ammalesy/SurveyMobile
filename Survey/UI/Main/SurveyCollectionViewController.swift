//
//  SurveyCollectionViewController.swift
//  Survey
//
//  Created by Apple on 10/8/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit
import SCLAlertView

let reuseIdentifier = "Cell"

class SurveyCollectionViewController: UICollectionViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SurveyCollectionViewCellDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /*======== LEFT BAR BUTTON ITEM ==========*/
        var menuBarButton:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_66"), style: UIBarButtonItemStyle.Plain, target: self, action: "toggleSideMenu")
        self.navigationItem.leftBarButtonItem = menuBarButton
        /*======== RIGHT BAR BUTTON ITEM ==========*/
        var refreshBarButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "refreshData:")
        refreshBarButton.tintColor = UIColor.whiteColor()
        var listProjectBarButton:UIBarButtonItem = UIBarButtonItem(title: "List project", style: UIBarButtonItemStyle.Plain, target: self, action: "goToListProject:")
        self.navigationItem.rightBarButtonItems = [listProjectBarButton,refreshBarButton]
        

        // Do any additional setup after loading the view.
        
        self.navigationItem.prompt = "Surveys"
        
        self.navigationItem.title = String(Session.sharedInstance.project_name_selected)
        //self.sideMenuController()?.sideMenu?.delegate = self
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        self.syncQuestionFromServer { () -> Void in
            self.navigationItem.prompt = "Surveys (\(AppDelegate.getDelegate().surveys.count))"
        }
        
    }
    func toggleSideMenu(){
        
        
        
        self.splitViewController?.toggleMasterView()
        
        
    }
    func refreshData(sender: AnyObject) {
        
        self.syncQuestionFromServer { () -> Void in
            
        }
        
    }
    func goToListProject(sender: AnyObject){
        AppDelegate.getDelegate().surveys.removeAllObjects()
        self.splitViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

//        var logo:UIImage = UIImage(named: "logo_survey")!
//        self.navigationItem.titleView = UIImageView(image: logo)
        
        
        
        
    }
    func syncQuestionFromServer(completionHandler:()->Void){
        
        CachingControl.getCache(CachingIdentifier.Survey, retriveCacheSuccess: { (cachingArray) -> Void in
            
            AppDelegate.getDelegate().surveys = cachingArray as! NSMutableArray
            self.collectionView?.reloadData()
            completionHandler()
            
        }) { () -> Void in
                var loadingView:SCLAlertView =  AlertUtil.showWaiting()
                MSurvey.get_surveys({ (surveys) -> Void in
                    loadingView.hideView()
                    AppDelegate.getDelegate().surveys = surveys
                    CachingControl.setCache(CachingIdentifier.Survey, data: surveys)
                    self.collectionView?.reloadData()
                    
                    CachingControl.setCacheDynamicKey(KEY_UPDATE_SURVEYS, data: DateUtil.dateFormater().stringFromDate(NSDate()))
                    completionHandler()
                    
                    }, failure: { (errorString) -> Void in
                        loadingView.hideView()
                        
                        AlertUtil.showAlertError("Network error.", detail: errorString)
                        
                        self.collectionView?.reloadData()
                        completionHandler()
                })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func openLeftPanel(sender: AnyObject)
    {
        toggleSideMenuView()
    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return AppDelegate.getDelegate().surveys.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var survey:MSurvey = AppDelegate.getDelegate().surveys.objectAtIndex(indexPath.row) as! MSurvey
        let cell:SurveyCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SurveyCollectionViewCell
        
        cell.delegate = self
        
        // Configure the cell
        cell.pTitleLabel.text = String(survey.pSm_name)
        cell.pDescription.text = String(survey.pSm_description)
        cell.pCountUserLabel.text = String(survey.pCountUser)
        cell.pImageView.image = UIImage(named: "default_icon_survey")
        
        println(survey.pSm_imageData)
        
        //Retrive On Memory
        var imageOnMem:UIImage? = cachingImageOnMemory.objectForKey(survey.pSm_image_id) as? UIImage
        if(imageOnMem == nil){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                
                var url:NSURL = NSURL(string: "\(Model.imagePath.url)/\(survey.pSm_image_id)")!
                var data = NSData(contentsOfURL: url)
                var image:UIImage = UIImage(data: data!)!
              
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    cell.pImageView.image = image
                    cachingImageOnMemory.setObject(image, forKey: survey.pSm_image_id)
                    
                });
                
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.pImageView.image = imageOnMem
            });
        }
        
        cell.layer.shouldRasterize = true;
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale;
    
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var bounds = UIScreen.mainScreen().bounds
        var size = CGSizeMake((bounds.size.width/2)-30, 250)
        return size
        
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var survey:MSurvey = AppDelegate.getDelegate().surveys.objectAtIndex(indexPath.row) as! MSurvey
        var user:MUser = MUser()
        user.pU_firstname = "dummy"
        user.pU_surname = "dummy"
        user.pU_age = "23".toInt()
        user.pU_sex = 0
        user.pU_email = "dummy"
        user.pU_tel = "dummy"
        var sb = UIStoryboard(name: "Main",bundle: nil);
        var controller:StartViewController = sb.instantiateViewControllerWithIdentifier("StartViewController") as! StartViewController
        controller.user = user
        controller.survey = survey.copy() as! MSurvey
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    func surveyCollectionViewCell(collectionViewCell: SurveyCollectionViewCell, infoClicked button: UIButton)
    {
//        let indexPath = self.collectionView!.indexPathForCell(collectionViewCell as UICollectionViewCell)
//        var survey:MSurvey = AppDelegate.getDelegate().surveys.objectAtIndex(indexPath!.row) as! MSurvey
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        self.collectionView?.reloadData()
        
    }
    


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
