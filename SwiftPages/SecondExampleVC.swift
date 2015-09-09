//
//  SecondExampleVC.swift
//  SwiftPages
//
//  Created by StarShine on 9/9/15.
//  Copyright (c) 2015 StarShine. All rights reserved.
//

import UIKit

class SecondExampleVC: UIViewController {

    @IBOutlet var swiftPagesView: SwiftPages!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Initiation
        let firstView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FirstVC") as! UIViewController
        let secondView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SecondVC") as! UIViewController
        let thirdView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ThirdVC") as! UIViewController
        let fourthView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FourthVC") as! UIViewController
        let fifthView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FifthVC") as! UIViewController
        let views : [UIViewController] = [firstView, secondView, thirdView, fourthView, fifthView]

        var buttonTitles : [String] = ["Home", "Places", "Photos", "List", "Tags"]
        
        //Sample customization
        swiftPagesView.initViews(views, buttonTitlesArray: buttonTitles)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
