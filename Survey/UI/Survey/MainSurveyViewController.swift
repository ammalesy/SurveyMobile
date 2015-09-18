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
    
    var pageViewController:UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "sendSurvey:")
        self.navigationItem.rightBarButtonItem = doneButton
//        doneButton.enabled = false
        
        var pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = ColorUtil.blueSky()
        pageControl.backgroundColor = UIColor.whiteColor()

        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        let startingViewController = self.viewController(0) as SurveyViewController
        self.pageViewController.setViewControllers([startingViewController.0], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        self.navigationItem.title = "Question 1 / \(self.survey.pQuestions.count)"
        
    }
    
    func sendSurvey(buttonItem:UIBarButtonItem) {
        
        var mul:NSMutableArray = survey.pQuestions;
        
    }

    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        
//        var controller:SurveyViewController = pendingViewControllers[0] as! SurveyViewController
//        if((controller.pageIndex + 1) == survey.pQuestions.count){
//            doneButton.enabled = true
//        }
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
        
        if(survey.pQuestions.count > 10) {
            return 10
        }else{
            return survey.pQuestions.count
        }
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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
