//
//  AnswerTxtTableViewCell.swift
//  Survey
//
//  Created by Apple on 10/11/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

@objc protocol AnswerTxtTableViewCellDelegate {
    
    optional  func answerTxtTableViewCell(cell: AnswerTxtTableViewCell, shouldInputString string: NSString) -> Void
    
}

class AnswerTxtTableViewCell: UITableViewCell,UITextFieldDelegate {

    
    var checked:Bool = false
    
    var delegate: AnswerTxtTableViewCellDelegate?
    
    @IBOutlet weak var seq: UILabel!
    @IBOutlet weak var ansDescriptionTxt: UITextField!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var ct_left_backgroundView: NSLayoutConstraint!
    @IBOutlet weak var ct_right_backgroundView: NSLayoutConstraint!
    
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
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        var stringConcat = "\(textField.text)\(string)" as NSString
        if(string == ""){
            if(textField.text != ""){
                stringConcat = textField.text as NSString
                stringConcat = String(stringConcat).substringToIndex(String(stringConcat).endIndex.predecessor())
            }
        }
        
        
        self.delegate?.answerTxtTableViewCell?(self, shouldInputString: stringConcat)
        return true
    }

}
