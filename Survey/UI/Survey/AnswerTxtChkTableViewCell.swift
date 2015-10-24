//
//  AnswerTxtChkTableViewCell.swift
//  Survey
//
//  Created by Apple on 10/23/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

@objc protocol AnswerTxtChkTableViewCellDelegate {
    
    optional  func answerTxtChkTableViewCell(cell: AnswerTxtChkTableViewCell, shouldInputString string: NSString) -> Void
    
}

class AnswerTxtChkTableViewCell: UITableViewCell,UITextFieldDelegate {
    
     var checked:Bool = false
     var delegate: AnswerTxtChkTableViewCellDelegate?
    
    @IBOutlet weak var seq: UILabel!
    @IBOutlet weak var ansDescription: UILabel!
    @IBOutlet weak var ansDescriptionTxt: UITextField!
    @IBOutlet weak var markImageView: UIImageView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var ct_left_backgroundView: NSLayoutConstraint!
    @IBOutlet weak var ct_right_backgroundView: NSLayoutConstraint!
    @IBOutlet weak var ct_top_markIcon: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ansDescriptionTxt.delegate = self
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad){
            ct_left_backgroundView.constant = 100
            ct_right_backgroundView.constant = 100
        }
        
        self.contentView.backgroundColor = UIColor.clearColor()
        self.backgroundColor = UIColor.clearColor()
        self.backgroundView?.backgroundColor = UIColor.clearColor()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if(selected){
            self.background.backgroundColor = UIColor.clearColor()
            self.markImageView.image = UIImage(named: "mark")
            
        }else{
            
            self.background.backgroundColor = UIColor.clearColor()
            self.markImageView.image = UIImage(named: "not-mark")

        }
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        var stringConcat = "\(textField.text)\(string)" as NSString
        if(string == ""){
            if(textField.text != ""){
                stringConcat = textField.text!
                stringConcat = String(stringConcat).substringToIndex(String(stringConcat).endIndex.predecessor())
            }
        }
        
        
        self.delegate?.answerTxtChkTableViewCell?(self, shouldInputString: stringConcat)
        return true
    }

}
