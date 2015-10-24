//
//  LoginViewController.swift
//  Survey
//
//  Created by Apple on 10/17/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var a_userTxt: UITextField!
    @IBOutlet weak var a_passTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let text = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String {
            let version = text.toDouble()
            self.versionLabel.text = "  Version \(version!)"
        }
        
        
        let session:Session =  Session.sharedInstance;
        CachingControl.getCache(CachingIdentifier.Session, retriveCacheSuccess: { (dictCache) -> Void in
            
            print(dictCache)
            
            session.a_id = (dictCache as! NSDictionary).objectForKey("a_id") as! NSString
            session.a_user = (dictCache as! NSDictionary).objectForKey("a_user") as! NSString
            session.a_name = (dictCache as! NSDictionary).objectForKey("a_name") as! NSString
            session.last_login = (dictCache as! NSDictionary).objectForKey("last_login") as! NSString
            session.isLogin = true
            session.getProject({ (project) -> Void in
                self.goMainPage()
            }, failur: { () -> Void in
                    AlertUtil.showAlertError("Error!", detail: "System error!")
            })
            
        }) { () -> Void in
            session.a_id = ""
            session.a_user = ""
            session.a_name = ""
            session.last_login = ""
            session.isLogin = false
        }
    }
    
    func goMainPage(){
        
        let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let contoller:UINavigationController = sb.instantiateViewControllerWithIdentifier("NavPJ") as! UINavigationController
        
        self.presentViewController(contoller, animated: true) { () -> Void in
            
            
            
        }
    
    }

   
    @IBAction func loginAction(sender: AnyObject) {
        let session:Session =  Session.sharedInstance;
        if (a_userTxt.text != "" && a_passTxt != ""){
            
            session.login(a_userTxt.text, a_pass: a_passTxt.text, success: { (session) -> Void in
                
                session.getProject({ (project) -> Void in
                    self.goMainPage()
                }, failur: { () -> Void in
                        AlertUtil.showAlertError("Error!", detail: "System error!")
                })
                
            }, failur: { () -> Void in
                    
                    AlertUtil.showAlertError("Error!", detail: "Login fail!")
                    
            })
            
        }else{
        
            AlertUtil.showAlertError("Warning!", detail: "Please fill require info.")
        }
        
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
