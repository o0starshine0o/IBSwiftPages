//
//  FirstExampleVC.swift
//  SwiftPages
//
//  Created by StarShine on 9/9/15.
//  Copyright (c) 2015 StarShine. All rights reserved.
//

import UIKit

class FirstExampleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Instantiation and the setting of the size and position
        let swiftPagesView : SwiftPages = SwiftPages(frame: CGRectMake(0, 64, self.view.frame.width, self.view.frame.height-64))
        
        //Initiation
        let firstView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FirstVC") as! UIViewController
        let secondView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SecondVC") as! UIViewController
        let thirdView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ThirdVC") as! UIViewController
        let fourthView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FourthVC") as! UIViewController
        let fifthView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FifthVC") as! UIViewController
        let views : [UIViewController] = [firstView, secondView, thirdView, fourthView, fifthView]
        var buttonImages : [UIImage] = [UIImage(named:"HomeIcon.png")!, UIImage(named:"LocationIcon.png")!, UIImage(named:"CollectionIcon.png")!, UIImage(named:"ListIcon.png")!, UIImage(named:"StarIcon.png")!]
        
        //Sample customization
        swiftPagesView.initViews(views, buttonImagesArray: buttonImages)
        swiftPagesView.aeroEffectInTopBar = false
        swiftPagesView.tabBackground = UIColor.orangeColor()
        
        self.view.addSubview(swiftPagesView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
