
//
//  SurveyViewController.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/15/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var user:MUser!
    var question:MQuestion!
    var pageIndex:NSInteger!

    @IBOutlet weak var titleQuestionLb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var ll:Int = question.pAnswers.count
        return ll
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let answer:MAnswer = question.pAnswers.objectAtIndex(indexPath.row) as! MAnswer
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        cell.textLabel?.text = String(indexPath.row + 1)
        cell.detailTextLabel?.text = String(answer.pAa_description)
        
        return cell
    }

}
