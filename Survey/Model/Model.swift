//
//  Model.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/12/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit


class Model: NSObject {
    struct basePath {
        static var url:NSString = "http://192.168.43.74/Survey/api"
    }
    func handleNullString(object:AnyObject)->(NSString){
        if let str = object as? NSString {
            return str
        }else{
            return ""
        }
    }
    func handleNullArray(object:AnyObject)->(NSMutableArray){
        if let arr = object as? NSMutableArray {
            return arr
        }else{
            return NSMutableArray()
        }
    }
    func handleNullDict(object:AnyObject)->(NSMutableDictionary){
        if let dict = object as? NSMutableDictionary {
            return dict
        }else{
            return NSMutableDictionary()
        }
    }
}
