//
//  AnswerTableViewCell.swift
//  Survey
//
//  Created by Apple on 9/18/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var seq: UILabel!
    @IBOutlet weak var ansDescription: UILabel!
    @IBOutlet weak var markImageView: UIImageView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var ct_left_backgroundView: NSLayoutConstraint!
    @IBOutlet weak var ct_right_backgroundView: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad){
            ct_left_backgroundView.constant = 100
            ct_right_backgroundView.constant = 100
            self.background.layer.cornerRadius = 3
            //            self.pContentView.layer.shadowColor = UIColor.darkGrayColor().CGColor
            //            self.pContentView.layer.shadowOffset = CGSizeMake(1, 1)
            //            self.pContentView.layer.shadowRadius = 1
            //            self.pContentView.layer.shadowOpacity = 0.3
            //self.pContentView.layer.shadowPath = UIBezierPath(rect: self.pContentView.frame).CGPath
            
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
