//
//  ProjectCollectionViewCell.swift
//  Survey
//
//  Created by Apple on 10/17/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pTitleLabel: UILabel!
    @IBOutlet weak var pDescription: UILabel!
    @IBOutlet weak var pImageView: UIImageView!
    @IBOutlet weak var pSmallImageView: UIImageView!
    @IBOutlet weak var pSeq: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
        
        pDescription.numberOfLines = 2
        
        
        pSmallImageView.layer.cornerRadius = pSmallImageView.frame.size.width / 2
        pSmallImageView.backgroundColor = ColorUtil.blueSky()
        pSmallImageView.layer.borderWidth = 5
        pSmallImageView.layer.borderColor = UIColor.whiteColor().CGColor
        pSmallImageView.layer.masksToBounds = true
        
        pSeq.layer.cornerRadius = pSeq.frame.size.width / 2
        pSeq.layer.masksToBounds = true
        
        
    }


    
}
