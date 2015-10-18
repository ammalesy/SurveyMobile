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
            var version = text.toDouble()
            self.versionLabel.text = "  Version \(version!)"
        }
        
        
        var session:Session =  Session.sharedInstance;
        if(session.isLogin){

            session.getProject({ (project) -> Void in
                self.goMainPage()
            }, failur: { () -> Void in
                AlertUtil.showAlertError("Error!", detail: "System error!")
            })
            
            
        }
    }
    
    func goMainPage(){
        
        var sb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var contoller:UINavigationController = sb.instantiateViewControllerWithIdentifier("NavPJ") as! UINavigationController
        
        self.presentViewController(contoller, animated: true) { () -> Void in
            
            
            
        }
    
    }

   
    @IBAction func loginAction(sender: AnyObject) {
        var session:Session =  Session.sharedInstance;
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
