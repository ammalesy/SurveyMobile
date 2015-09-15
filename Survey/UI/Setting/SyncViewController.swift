//
//  SyncViewController.swift
//  Survey
//
//  Created by AmmalesPSC91 on 9/14/2558 BE.
//  Copyright (c) 2558 dev.com. All rights reserved.
//

import UIKit

class SyncViewController: UIViewController,ENSideMenuDelegate {

    @IBAction func openMenu(sender: AnyObject) {
         toggleSideMenuView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        var logo:UIImage = UIImage(named: "logo_survey")!
        self.navigationItem.titleView = UIImageView(image: logo)
        self.sideMenuController()?.sideMenu?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
