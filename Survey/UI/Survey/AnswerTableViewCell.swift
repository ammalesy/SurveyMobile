//
//  AnswerTableViewCell.swift
//  Survey
//
//  Created by Apple on 9/18/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    var checked:Bool = false
    
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
        }
        
        
        
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

}
