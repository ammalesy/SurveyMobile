//
//  MenuTableViewCell.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/14/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    var indexPath:NSIndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if(selected){
            self.backgroundColor = UIColor.clearColor()
            self.textLabel!.textColor = ColorUtil.darkGray()
            if(indexPath.row == 1){
                self.imageView?.image = UIImage(named: "Settings-50_selected")
            }else{
                self.imageView?.image = UIImage(named: "Document-50_selected")
            }

        }else{
            self.backgroundColor = UIColor.clearColor()
            self.textLabel!.textColor = UIColor.whiteColor()
            if(indexPath.row == 1){
                self.imageView?.image = UIImage(named: "Settings-50")
            }else{
                self.imageView?.image = UIImage(named: "Document-50")
            }

            
        }
        
    }

}
