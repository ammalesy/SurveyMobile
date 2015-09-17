//
//  MainSurveyViewController.swift
//  Survey
//
//  Created by Apple on 9/16/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class MainSurveyViewController: UIViewController,UIPageViewControllerDataSource {
    
    var user:MUser!
    var survey:MSurvey!
    
    var pageViewController:UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let startingViewController = self.viewController(0) as SurveyViewController
        self.pageViewController.setViewControllers([startingViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true) { (flag) -> Void in
            
            if (flag) {
                self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30)
                self.addChildViewController(self.pageViewController)
                self.view.addSubview(self.pageViewController.view)
                self.pageViewController.didMoveToParentViewController(self)
   
            }
        }
        
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index:NSInteger = (viewController as! SurveyViewController).pageIndex
        
        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        
        index--
        return self.viewController(index)
        
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
        return self.viewController(index)
        
    }
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return survey.pQuestions.count
//    }
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
    func viewController(atIndex:NSInteger!) -> SurveyViewController!
    {
        if ((survey.pQuestions.count == 0) || (atIndex >= survey.pQuestions.count)) {
            return nil
        }
    
    // Create a new view controller and pass suitable data.
        let pageContentViewController:SurveyViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SurveyViewController") as! SurveyViewController
        pageContentViewController.user = self.user
        pageContentViewController.question = self.survey.pQuestions.objectAtIndex(atIndex) as! MQuestion
        pageContentViewController.pageIndex = atIndex;
    
    return pageContentViewController;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
