//
//  MainSurveyViewController.swift
//  Survey
//
//  Created by Apple on 9/16/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class MainSurveyViewController: UIViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    var user:MUser!
    var survey:MSurvey!
    
    var pageViewController:UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = ColorUtil.blueSky()
        pageControl.backgroundColor = UIColor.whiteColor()

        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        let startingViewController = self.viewController(0) as (SurveyViewController,UIViewController,isLast:Bool)
        self.pageViewController.setViewControllers([startingViewController.0], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        self.navigationItem.title = "Question 1 / \(self.survey.pQuestions.count)"
        
    }

    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        
        var index:NSInteger = (pendingViewControllers[0] as! SurveyViewController).pageIndex
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.navigationItem.title = "Question \(index + 1) / \(self.survey.pQuestions.count)"
        });
        
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index:NSInteger = (viewController as! SurveyViewController).pageIndex

        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        
        index--
        var result = self.viewController(index) as (SurveyViewController,UIViewController,isLast:Bool)
        if(result.isLast){
            return result.1
        }
        return result.0
        
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
        
        var result = self.viewController(index) as (SurveyViewController,UIViewController,isLast:Bool)
        if(result.isLast){
            return result.1
        }
        return result.0
        
    }
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return survey.pQuestions.count + 1
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func viewController(atIndex:NSInteger!) -> (SurveyViewController,UIViewController,isLast:Bool)!
    {
        if ((survey.pQuestions.count == 0)) {
            return nil
        }
        
        if(atIndex >= survey.pQuestions.count) {
            var last:SubmitViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SubmitViewController") as! SubmitViewController
            return (SurveyViewController(),last,false)
        }
        
        let pageContentViewController:SurveyViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SurveyViewController") as! SurveyViewController
        pageContentViewController.user = self.user
        pageContentViewController.question = self.survey.pQuestions.objectAtIndex(atIndex) as! MQuestion
        pageContentViewController.pageIndex = atIndex
        pageContentViewController.numberOfQuestion = survey.pQuestions.count

        
    
        return (pageContentViewController,UIViewController(),false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
