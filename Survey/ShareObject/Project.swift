//
//  Project.swift
//  Survey
//
//  Created by Apple on 10/17/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class Project: NSObject {
    static let sharedInstance = Project()
    
    
    var listProject:NSMutableArray = NSMutableArray()
    
    
    func clear(){
        listProject.removeAllObjects()
    }
   
}
