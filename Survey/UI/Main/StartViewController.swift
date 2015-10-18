//
//  StartViewController.swift
//  Survey
//
//  Created by Apple on 10/18/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    var user:MUser!
    var survey:MSurvey!
    var currentIndex:NSInteger!
    
    @IBOutlet weak var surveyNameLabel: UILabel!
    @IBOutlet weak var questionCoutLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.prompt = String(survey.pSm_name)
        self.navigationItem.title = "Welcome"
        
        startSurveyButton.layer.cornerRadius = startSurveyButton.frame.size.width / 2
        startSurveyButton.layer.masksToBounds = true
        
        surveyNameLabel.text = "Survey name : \(survey.pSm_name)"
        questionCoutLabel.text = "Question : \(survey.pQuestions.count)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var startSurveyButton: UIButton!
    @IBAction func startSurveyAction(sender: AnyObject) {
        
        var sb = UIStoryboard(name: "Main",bundle: nil);
        var controller:MainSurveyViewController = sb.instantiateViewControllerWithIdentifier("MainSurveyViewController") as! MainSurveyViewController
        controller.user = user
        controller.survey = survey
        self.navigationController?.pushViewController(controller, animated: true)
        
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
