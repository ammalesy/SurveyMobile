//
//  ProjectCollectionViewController.swift
//  Survey
//
//  Created by Apple on 10/17/15.
//  Copyright (c) 2015 dev.com. All rights reserved.
//

import UIKit

//let reuseIdentifier = "Cell"

class ProjectCollectionViewController: UICollectionViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        var logo:UIImage = UIImage(named: "logo_survey")!
        self.navigationItem.titleView = UIImageView(image: logo)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        self.navigationItem.prompt = "\(Session.sharedInstance.a_name)"
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        
        Session.sharedInstance.clear()
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return Project.sharedInstance.listProject.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var project:MProject = Project.sharedInstance.listProject.objectAtIndex(indexPath.row) as! MProject
        let cell:ProjectCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CellPj", forIndexPath: indexPath) as! ProjectCollectionViewCell
        
        println(Project.sharedInstance.listProject)
        println(project.pPj_name)
        // Configure the cell
        cell.pSeq.text = String(indexPath.row + 1)
        cell.pTitleLabel.text = String(project.pPj_name)
        cell.pDescription.text = String(project.pPj_description)
        cell.pImageView.image = UIImage(named: "default_icon_survey")
          
        
        //Retrive On Memory
        var imageOnMem:UIImage? = cachingImagePJOnMemory.objectForKey(project.pPj_image) as? UIImage
        if(imageOnMem == nil){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                
                var url:NSURL = NSURL(string: "\(Model.imageProjectPath.url)/\(project.pPj_image)")!
                var data = NSData(contentsOfURL: url)
                var image:UIImage = UIImage(data: data!)!
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    cell.pImageView.image = image
                    cell.pSmallImageView.image = image
                    cachingImagePJOnMemory.setObject(image, forKey: project.pPj_image)
                    
                });
                
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.pImageView.image = imageOnMem
                cell.pSmallImageView.image = imageOnMem
            });
        }
        cell.layer.shouldRasterize = true;
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale;
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        var bounds = UIScreen.mainScreen().bounds
        
        var size = CGSizeMake((bounds.size.width/2)-30, 250)
        return size
        
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        var project:MProject = Project.sharedInstance.listProject.objectAtIndex(indexPath.row) as! MProject
        Session.sharedInstance.project_selected = project.pPj_db_ref
        Session.sharedInstance.project_name_selected = project.pPj_name

        var sb = UIStoryboard(name: "Main",bundle: nil);
        var controller:SplitViewController = sb.instantiateViewControllerWithIdentifier("SplitViewController") as! SplitViewController
        
        
        self.presentViewController(controller, animated: true) { () -> Void in
  
            
        }
        
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        self.collectionView?.reloadData()
        
    }

}
