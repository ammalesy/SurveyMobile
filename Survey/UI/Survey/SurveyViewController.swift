
//
//  SurveyViewController.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/15/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

let CHECKBOX_IDENTIFIER = "0"
let TEXTBOX_IDENTIFIER = "1"
let RADIO_IDENTIFIER = "2"
let CHECKBOX_TEXTBOX_IDENTIFIER = "3"
let RADIO_TEXTBOX_IDENTIFIER = "4"

class SurveyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,AnswerTxtTableViewCellDelegate,AnswerTxtChkTableViewCellDelegate {
    
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
        let view:UILabel = UILabel()
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
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath.row) as! MAnswer
        
        if(answer.pAnswerStyle.pAs_identifier.isEqualToString(CHECKBOX_TEXTBOX_IDENTIFIER) ||
            answer.pAnswerStyle.pAs_identifier.isEqualToString(RADIO_TEXTBOX_IDENTIFIER)){
                
                if(answer.pChecked == false){
                    return 75
                }else{
                    return 111
                }
                
                
        }
        
        return 75
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath.row) as! MAnswer
        
        if(answer.pAnswerStyle.pAs_identifier.isEqualToString(CHECKBOX_IDENTIFIER)){
            
            let cell:AnswerTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! AnswerTableViewCell
            print(cell)
            cell.seq.text = "\(indexPath.row + 1)"
            cell.ansDescription.text = "\(answer.pAa_description)"
            cell.ansDescription.textColor = UIColor(hexString: answer.pAnswerStyle.pAs_text_color)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if(answer.pChecked){
                    cell.markImageView.image = UIImage(named: "mark")
                }else{
                    cell.markImageView.image = UIImage(named: "not-mark")
                }
            })
            
            return cell
        
        }else if(answer.pAnswerStyle.pAs_identifier.isEqualToString(TEXTBOX_IDENTIFIER)){
            
            let cell:AnswerTxtTableViewCell = tableView.dequeueReusableCellWithIdentifier("CellTxt") as! AnswerTxtTableViewCell
            cell.seq.text = "\(indexPath.row + 1)";
            if(answer.pChecked == true){
                if(String(answer.pTextFromTxtBox) != nil){
                    cell.ansDescriptionTxt.text = String(answer.pTextFromTxtBox)
                }
            }
            
            cell.ansDescriptionTxt.placeholder = "\(answer.pAa_description)"
            cell.ansDescriptionTxt.textColor = UIColor(hexString: answer.pAnswerStyle.pAs_text_color)
            cell.delegate = self
            return cell
            
        }else if(answer.pAnswerStyle.pAs_identifier.isEqualToString(RADIO_IDENTIFIER)){
            
            let cell:AnswerTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! AnswerTableViewCell
            cell.seq.text = "\(indexPath.row + 1)";
            cell.ansDescription.text = "\(answer.pAa_description)"
            cell.ansDescription.textColor = UIColor(hexString: answer.pAnswerStyle.pAs_text_color)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if(answer.pChecked){
                    cell.markImageView.image = UIImage(named: "mark")
                }else{
                    cell.markImageView.image = UIImage(named: "not-mark")
                }
            })
            
            return cell
            
        }else if((answer.pAnswerStyle.pAs_identifier.isEqualToString(CHECKBOX_TEXTBOX_IDENTIFIER)) ||
                 (answer.pAnswerStyle.pAs_identifier.isEqualToString(RADIO_TEXTBOX_IDENTIFIER))){
            
            let cell:AnswerTxtChkTableViewCell = tableView.dequeueReusableCellWithIdentifier("CellTxtChk") as! AnswerTxtChkTableViewCell
            cell.seq.text = "\(indexPath.row + 1)";
            cell.ansDescription.text = "\(answer.pAa_description)"
            cell.ansDescription.textColor = UIColor(hexString: answer.pAnswerStyle.pAs_text_color)
            if(answer.pChecked == true){
                if(String(answer.pTextFromTxtBox) != nil){
                    cell.ansDescriptionTxt.text = String(answer.pTextFromTxtBox)
                }
            }
            
            cell.ansDescriptionTxt.placeholder = "ระบุ"
            cell.delegate = self
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if(answer.pChecked){
                    cell.markImageView.image = UIImage(named: "mark")
                    cell.ansDescriptionTxt.alpha = 1
                }else{
                    cell.markImageView.image = UIImage(named: "not-mark")
                    cell.ansDescriptionTxt.alpha = 0
                }
            })
            
            return cell
            
        }else{
            return UITableViewCell()
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath.row) as! MAnswer
        
        if(answer.pAnswerStyle.pAs_identifier.isEqualToString(CHECKBOX_IDENTIFIER)){
            answer.pChecked = !answer.pChecked
        }else if(answer.pAnswerStyle.pAs_identifier.isEqualToString(TEXTBOX_IDENTIFIER)){
            answer.pChecked = true
        }else if(answer.pAnswerStyle.pAs_identifier.isEqualToString(RADIO_IDENTIFIER)){
            answer.pChecked = true
            self.resetAnotherRadio(answer)
        }else if(answer.pAnswerStyle.pAs_identifier.isEqualToString(CHECKBOX_TEXTBOX_IDENTIFIER)){
            answer.pChecked = !answer.pChecked
            if(answer.pChecked == false){
                answer.pTextFromTxtBox = ""
            }
            
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        }else if(answer.pAnswerStyle.pAs_identifier.isEqualToString(RADIO_TEXTBOX_IDENTIFIER)){
            answer.pChecked = true
            answer.pTextFromTxtBox = ""
            
            self.resetAnotherRadio(answer)
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        }
        
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath.row) as! MAnswer
        
        if(answer.pAnswerStyle.pAs_identifier.isEqualToString(RADIO_TEXTBOX_IDENTIFIER) ||
           answer.pAnswerStyle.pAs_identifier.isEqualToString(RADIO_IDENTIFIER)){
           
            answer.pChecked = true
        
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        }
    }
    func answerTxtTableViewCell(cell: AnswerTxtTableViewCell, shouldInputString string: NSString) {
        
        let indexPath = self.tableView!.indexPathForCell(cell as UITableViewCell)
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath!.row) as! MAnswer
        
        answer.pTextFromTxtBox = string
        print(string)
    }
    func answerTxtChkTableViewCell(cell: AnswerTxtChkTableViewCell, shouldInputString string: NSString) {
        let indexPath = self.tableView!.indexPathForCell(cell as UITableViewCell)
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath!.row) as! MAnswer
        
        answer.pTextFromTxtBox = string
        print(string)
    }
    func resetAnotherRadio(answerSelected:MAnswer){
        //RESET ANOTHER RADIO
        var i:NSInteger = 0
        let arrayRefresh:NSMutableArray = NSMutableArray()
        for ans:MAnswer in question.pAnswers as Array as! [MAnswer] {
            if answerSelected.pAa_id != ans.pAa_id {
                if ans.pAnswerStyle.pAs_identifier == RADIO_IDENTIFIER ||
                   ans.pAnswerStyle.pAs_identifier == RADIO_TEXTBOX_IDENTIFIER
                {
                    ans.pChecked = false
                    ans.pTextFromTxtBox = ""
                    arrayRefresh.addObject(NSIndexPath(forRow: i, inSection: 0))
                }
            }
            i++
        }
        let converArray:NSArray = NSArray(array: arrayRefresh)
        self.tableView.reloadRowsAtIndexPaths(converArray as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        /////////////////////
    }
    func setDefaultRadio(){
        var notSelectYet:Bool = true
        
        for ans:MAnswer in question.pAnswers as Array as! [MAnswer] {
            
            if ans.pAnswerStyle.pAs_identifier == RADIO_IDENTIFIER ||
               ans.pAnswerStyle.pAs_identifier == RADIO_TEXTBOX_IDENTIFIER{
                if(ans.pChecked == true) {
                    notSelectYet = false
                    break;
                }
            }
            
        }
        
        if(notSelectYet == true){
            for ans:MAnswer in question.pAnswers as Array as! [MAnswer] {
            
                if ans.pAnswerStyle.pAs_identifier == RADIO_IDENTIFIER ||
                   ans.pAnswerStyle.pAs_identifier == RADIO_TEXTBOX_IDENTIFIER{
                    ans.pChecked = true
                    break;
                }
            
            }
        }
    }

}
