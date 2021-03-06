//
//  DateUtil.swift
//  Survey
//
//  Created by Apple on 9/19/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class DateUtil: NSObject {
    class func dateFormater()->NSDateFormatter{
        let gregorianCalendar = NSCalendar(identifier:NSCalendarIdentifierGregorian)
        let formatDate:NSDateFormatter = NSDateFormatter()
        formatDate.calendar = gregorianCalendar
        formatDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatDate
    }
}
