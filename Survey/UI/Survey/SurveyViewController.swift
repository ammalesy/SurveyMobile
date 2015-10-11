
//
//  SurveyViewController.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/15/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,AnswerTxtTableViewCellDelegate {
    
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
        self.setDefaultRadio()
        
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
        view.backgroundColor = UIColor.whiteColor()
        view.text = "  Answers : (\(question.pAnswers.count))"
        view.textColor = ColorUtil.orangeStronger()
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
        
        if(answer.pType.isEqualToString("0")){
            
            var cell:AnswerTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! AnswerTableViewCell
            println(cell)
            cell.seq.text = "\(indexPath.row + 1)"
            cell.ansDescription.text = "\(answer.pAa_description)"
            cell.ansDescription.textColor = UIColor(hexString: answer.pAa_color)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if(answer.pChecked){
                    cell.markImageView.image = UIImage(named: "mark")
                }else{
                    cell.markImageView.image = UIImage(named: "not-mark")
                }
            })
            
            return cell
        
        }else if(answer.pType.isEqualToString("1")){
            
            var cell:AnswerTxtTableViewCell = tableView.dequeueReusableCellWithIdentifier("CellTxt") as! AnswerTxtTableViewCell
            cell.seq.text = "\(indexPath.row + 1)";
            cell.ansDescriptionTxt.placeholder = "\(answer.pAa_description)"
            cell.ansDescriptionTxt.textColor = UIColor(hexString: answer.pAa_color)
            cell.delegate = self
            return cell
            
        }else{
            
            var cell:AnswerTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! AnswerTableViewCell
            cell.seq.text = "\(indexPath.row + 1)";
            cell.ansDescription.text = "\(answer.pAa_description)"
            cell.ansDescription.textColor = UIColor(hexString: answer.pAa_color)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if(answer.pChecked){
                    cell.markImageView.image = UIImage(named: "mark")
                }else{
                    cell.markImageView.image = UIImage(named: "not-mark")
                }
            })
            
            return cell
            
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath.row) as! MAnswer
        
        if(answer.pType.isEqualToString("0")){
            answer.pChecked = !answer.pChecked
        }else if(answer.pType.isEqualToString("1")){
            answer.pChecked = true
        }else{
            answer.pChecked = !answer.pChecked
            self.resetAnotherRadio(answer)
        }
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath.row) as! MAnswer
        
        if(answer.pType.isEqualToString("2")){
            var arrayRefresh:NSMutableArray = NSMutableArray()
            answer.pChecked = true
            arrayRefresh.addObject(indexPath)
            self.tableView.reloadRowsAtIndexPaths(arrayRefresh as [AnyObject], withRowAnimation: UITableViewRowAnimation.None)
        }
    }
    func answerTxtTableViewCell(cell: AnswerTxtTableViewCell, shouldInputString string: NSString) {
        
        let indexPath = self.tableView!.indexPathForCell(cell as UITableViewCell)
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath!.row) as! MAnswer
        
        answer.pTextFromTxtBox = string
        println(string)
    }
    
    func resetAnotherRadio(answerSelected:MAnswer){
        //RESET ANOTHER RADIO
        var i:NSInteger = 0
        var arrayRefresh:NSMutableArray = NSMutableArray()
        for ans:MAnswer in question.pAnswers as Array as! [MAnswer] {
            if answerSelected.pAa_id != ans.pAa_id {
                if ans.pType == "2" {
                    ans.pChecked = false
                    arrayRefresh.addObject(NSIndexPath(forRow: i, inSection: 0))
                }
            }
            i++
        }
        self.tableView.reloadRowsAtIndexPaths(arrayRefresh as [AnyObject], withRowAnimation: UITableViewRowAnimation.Fade)
        /////////////////////
    }
    func setDefaultRadio(){
        var notSelectYet:Bool = true
        
        for ans:MAnswer in question.pAnswers as Array as! [MAnswer] {
            
            if ans.pType == "2" {
                if(ans.pChecked == true) {
                    notSelectYet = false
                    break;
                }
            }
            
        }
        
        if(notSelectYet == true){
            for ans:MAnswer in question.pAnswers as Array as! [MAnswer] {
            
                if ans.pType == "2" {
                    ans.pChecked = true
                    break;
                }
            
            }
        }
    }

}
