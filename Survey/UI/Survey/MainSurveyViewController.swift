//
//  MainSurveyViewController.swift
//  Survey
//
//  Created by Apple on 9/16/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class MainSurveyViewController: UIViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    var doneButton:UIBarButtonItem!
    var user:MUser!
    var survey:MSurvey!
    var currentIndex:NSInteger!
    
    var pageViewController:UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        currentIndex = 0
        
        doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "sendSurvey:")
        self.navigationItem.rightBarButtonItem = doneButton
        doneButton.enabled = false
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = ColorUtil.orangeLight()
        pageControl.currentPageIndicatorTintColor = ColorUtil.darkGray()
        pageControl.backgroundColor = UIColor.whiteColor()

        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        let startingViewController = self.viewController(0) as SurveyViewController
        self.pageViewController.setViewControllers([startingViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        self.navigationItem.title = "Question 1 / \(self.survey.pQuestions.count)"
        self.navigationItem.prompt = String(survey.pSm_name)
        
    }
    
    func nextPage(){
        print(currentIndex)
        self.gotoPage(currentIndex+1, isNext: true)
        currentIndex = currentIndex+1
        print(currentIndex)
    }
    func prevPage(){
        self.gotoPage(currentIndex-1, isNext: false)
        currentIndex = currentIndex-1
    }
    func gotoPage(pageNumber:NSInteger,isNext:Bool){
        let viewcontroller = self.viewController(pageNumber) as SurveyViewController
        
        var direction:UIPageViewControllerNavigationDirection = UIPageViewControllerNavigationDirection.Forward
        if(isNext == false){
            direction = UIPageViewControllerNavigationDirection.Reverse
        }
        
        self.pageViewController.setViewControllers([viewcontroller], direction: direction, animated: true, completion: nil)
    }
    func sendSurvey(buttonItem:UIBarButtonItem) {
        
        //var mul:NSMutableArray = survey.pQuestions;
        let sync:MSync = MSync.convertToSyncFormat(survey, user: user)
        
        CachingControl.getCache(CachingIdentifier.SurVeyResultList, retriveCacheSuccess: { (listCache) -> Void in
            
            let list:NSMutableArray = listCache as! NSMutableArray
            list.addObject(sync)
            CachingControl.setCache(CachingIdentifier.SurVeyResultList, data: list)
    
            AlertUtil.showAlertSuccess("Succesfully", detail: "Thank you very much.", completion: { () -> Void! in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.navigationController!.popToRootViewControllerAnimated(true)
                })
            })
            
            self.survey.pCountUser = self.survey.pCountUser + 1
            self.survey.updateCache()

            for(var i = 0; i < AppDelegate.getDelegate().surveys.count; i++){
                if ((AppDelegate.getDelegate().surveys[i] as! MSurvey).pSm_id == self.survey.pSm_id) {
                    (AppDelegate.getDelegate().surveys[i] as! MSurvey).pCountUser = (AppDelegate.getDelegate().surveys[i] as! MSurvey).pCountUser + 1
                }
            }
            
        }) { () -> Void in
            let list:NSMutableArray = NSMutableArray()
            list.addObject(sync)
            print(list[0].description)
            CachingControl.setCache(CachingIdentifier.SurVeyResultList, data: list)
            
            AlertUtil.showAlertSuccess("Succesfully", detail: "Thank you very much.", completion: { () -> Void! in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.navigationController!.popToRootViewControllerAnimated(true)
                })
            })
            
            self.survey.pCountUser = self.survey.pCountUser + 1
            self.survey.updateCache()
        }
        
    }

//    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
//        
//        let controller:SurveyViewController = pendingViewControllers[0] as! SurveyViewController
//        currentIndex = controller.pageIndex
////        if((controller.pageIndex + 1) == survey.pQuestions.count){
////            doneButton.enabled = true
////        }
//    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        
        let controller:SurveyViewController = pendingViewControllers[0] as! SurveyViewController
        currentIndex = controller.pageIndex
        
        if((controller.pageIndex + 1) == survey.pQuestions.count){
            doneButton.enabled = true
        }else{
            doneButton.enabled = false
        }
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index:NSInteger = (viewController as! SurveyViewController).pageIndex

        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        
        index--
        
        return self.viewController(index) as SurveyViewController
        
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index:NSInteger = (viewController as! SurveyViewController).pageIndex

        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        if (index == survey.pQuestions.count) {
            return nil
        }
        
        return self.viewController(index) as SurveyViewController
        
    }
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        let pageControl = UIPageControl.appearance()
        
        if(survey.pQuestions.count > 18) {
            pageControl.numberOfPages = 18
            return 18
        }else{
            
            return survey.pQuestions.count
        }
        
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        
        return currentIndex
    }
    
    func viewController(atIndex:NSInteger!) -> (SurveyViewController)!
    {
        if ((survey.pQuestions.count == 0) || atIndex >= survey.pQuestions.count) {
            return nil
        }
        
        let pageContentViewController:SurveyViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SurveyViewController") as! SurveyViewController
        pageContentViewController.user = self.user
        pageContentViewController.question = self.survey.pQuestions.objectAtIndex(atIndex) as! MQuestion
        pageContentViewController.pageIndex = atIndex
        pageContentViewController.numberOfQuestion = survey.pQuestions.count
        pageContentViewController.mainController = self

        return pageContentViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
