
//
//  SurveyViewController.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/15/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var user:MUser!
    var numberOfQuestion:NSInteger!
    var question:MQuestion!
    var pageIndex:NSInteger!
    var mainController:MainSurveyViewController!

    @IBOutlet weak var questionLb: UILabel!
    @IBOutlet weak var seqLb: UILabel!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        questionLb.text = String(question.pAq_description)
        seqLb.text = String(pageIndex + 1)
        
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.mainController.navigationItem.title = "Question \(self.pageIndex + 1) / \(self.mainController.survey.pQuestions.count)"
        });
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view:UILabel = UILabel()
        view.backgroundColor = UIColor.whiteColor()//UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        view.text = "  Answers : (\(question.pAnswers.count))"
        view.textColor = UIColor(red: 94/255.0, green: 190/255.0, blue: 202/255.0, alpha: 1)
        view.font = UIFont.boldSystemFontOfSize(14)
        return view
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return question.pAnswers.count
        

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath.row) as! MAnswer
        
        let cell:AnswerTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! AnswerTableViewCell
        cell.seq.text = "\(indexPath.row + 1)"
        cell.ansDescription.text = "\(answer.pAa_description)"
        cell.checked = answer.pChecked

        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath.row) as! MAnswer
        answer.pChecked = !answer.pChecked
    }

}
