//
//  SurveyCollectionViewCell.swift
//  Survey
//
//  Created by Apple on 10/10/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

@objc protocol SurveyCollectionViewCellDelegate {
    
  optional  func surveyCollectionViewCell(collectionViewCell: SurveyCollectionViewCell, infoClicked button: UIButton) -> Void

}

class SurveyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pTitleLabel: UILabel!
    @IBOutlet weak var pCountUserLabel: UILabel!
    @IBOutlet weak var pDescription: UILabel!
    @IBOutlet weak var pImageView: UIImageView!
    
    var delegate: SurveyCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
        
        pDescription.numberOfLines = 2
        
        
        pImageView.layer.cornerRadius = pImageView.frame.size.width / 2
        pImageView.backgroundColor = ColorUtil.blueSky()
        pImageView.layer.borderWidth = 5
        pImageView.layer.borderColor = ColorUtil.blueSkyLight().CGColor
        pImageView.layer.masksToBounds = true
        
        pCountUserLabel.layer.cornerRadius = pCountUserLabel.frame.size.width / 2
        pCountUserLabel.layer.masksToBounds = true
        
        
        
        
        
//
//        UIBezierPath(roundedRect: pImageView.frame, cornerRadius: pImageView.layer.cornerRadius)
//        UIBezierPath(roundedRect: pCountUserLabel.frame, cornerRadius: pCountUserLabel.layer.cornerRadius)
        
//        pImageView.layer.shouldRasterize = true;
//        pCountUserLabel.layer.shouldRasterize = true;
        
    }
    @IBAction func infoClicked(sender: AnyObject) {
        

        //if(self.delegate?.respondsToSelector(Selector("surveyCollectionViewCell::"))){
            self.delegate?.surveyCollectionViewCell?(self, infoClicked: sender as! UIButton)
        //}
        
    }
    
}
