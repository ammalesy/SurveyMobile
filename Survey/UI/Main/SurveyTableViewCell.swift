//
//  SurveyTableViewCell.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/13/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

class SurveyTableViewCell: UITableViewCell {

    @IBOutlet weak var pContentView: UIView!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var pDescription: UILabel!
    @IBOutlet weak var ptitleAmount: UILabel!
    @IBOutlet weak var pAmount: UILabel!
    @IBOutlet weak var lineCell: UIView!
    
    @IBOutlet weak var lb_seq: UILabel!
    @IBOutlet weak var ct_right_lineCell: NSLayoutConstraint!
    @IBOutlet weak var ct_left_lineCell: NSLayoutConstraint!
    @IBOutlet weak var ct_top_contentView: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad){
            ct_right_contentView.constant = 100
            ct_left_contentView.constant = 100
            self.pContentView.layer.cornerRadius = 3
//            self.pContentView.layer.shadowColor = UIColor.darkGrayColor().CGColor
//            self.pContentView.layer.shadowOffset = CGSizeMake(1, 1)
//            self.pContentView.layer.shadowRadius = 1
//            self.pContentView.layer.shadowOpacity = 0.3
            //self.pContentView.layer.shadowPath = UIBezierPath(rect: self.pContentView.frame).CGPath
            
        }
        self.contentView.backgroundColor = UIColor.clearColor()
        
//        let blurEffect = UIBlurEffect(style: .Light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.lineCell.bounds
//        self.lineCell.addSubview(blurEffectView)
        
    }
    @IBOutlet weak var ct_left_contentView: NSLayoutConstraint!
    @IBOutlet weak var ct_right_contentView: NSLayoutConstraint!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected){
            self.pContentView.backgroundColor = UIColor(red: 82/255, green: 194/255, blue: 209/255, alpha: 1)
            self.pTitle.textColor = UIColor.whiteColor()
            self.pDescription.textColor = UIColor.whiteColor()
            self.ptitleAmount.textColor = UIColor.whiteColor()
            self.pAmount.textColor = UIColor.whiteColor()
        }else{
            self.pContentView.backgroundColor = UIColor.whiteColor()
            self.pTitle.textColor = UIColor(red: 82/255, green: 194/255, blue: 209/255, alpha: 1)
            self.pDescription.textColor = UIColor(red: 82/255, green: 194/255, blue: 209/255, alpha: 1)
            self.ptitleAmount.textColor = UIColor(red: 223/255, green: 118/255, blue: 86/255, alpha: 1)
            self.pAmount.textColor = UIColor(red: 223/255, green: 118/255, blue: 86/255, alpha: 1)
        }
        
        // Configure the view for the selected state
    }

}
