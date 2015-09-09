//
//  SwiftPages.swift
//  SwiftPages
//
//  Created by StarShine on 9/9/15.
//  Copyright (c) 2015 StarShine. All rights reserved.
//

import UIKit

@IBDesignable class SwiftPages: UIView, UIScrollViewDelegate {

    //Items variables
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var topBar: UIView!
    private var animatedBar: UIView!
    private var buttonTitles: [String] = []
    private var buttonImages: [UIImage] = []
    private var pageViews:[UIViewController] = []
    
    //Container view position variables
    private var xOrigin: CGFloat = 0
    private var yOrigin: CGFloat = 0
    private var distanceToBottom: CGFloat = 0
    
    //Color variables
    @IBInspectable var tabBarColor:UIColor = UIColor.whiteColor()
    @IBInspectable var tabBackground:UIColor = UIColor.blueColor()
    @IBInspectable var tabTextColor:UIColor = UIColor.whiteColor()
    @IBInspectable var containerViewBackground:UIColor = UIColor.redColor()
    //Bar item variables
    @IBInspectable var aeroEffectInTopBar: Bool = true //This gives the top bap a blurred effect, also overlayes the it over the VC's
    
    //Item size variables
    private var topBarHeight: CGFloat = 52
    private var animatedBarHeight: CGFloat = 3
    
    override func drawRect(rect: CGRect){
        let pageCount = pageViews.count
        let width = self.frame.size.width
        let height = self.frame.size.height
        
        //Set the scrollview
        if scrollView == nil {
            if aeroEffectInTopBar {
                scrollView = UIScrollView(frame: CGRectMake(0, 0, width, height))
            } else {
                scrollView = UIScrollView(frame: CGRectMake(0, topBarHeight, width, height - topBarHeight))
            }
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.backgroundColor = UIColor.clearColor()
            self.addSubview(scrollView)
        }
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        
        // Add ViewController to scrollview
        for index in 0..<pageCount{
            var newPage: UIViewController = pageViews[index]
            newPage.view.frame.origin.x = scrollView.bounds.size.width * CGFloat(index)
            scrollView.addSubview(newPage.view)
        }
        
        //Set the top bar
        if topBar == nil{
            topBar = UIView(frame: CGRectMake(0, 0, width, topBarHeight))
            topBar.backgroundColor = tabBackground
            self.addSubview(topBar)
        }
        if (aeroEffectInTopBar) {
            //Create the blurred visual effec.You can choose between ExtraLight, Light and Dark
            topBar.backgroundColor = UIColor.clearColor()
            let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = topBar.bounds
            blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
            topBar.addSubview(blurView)
        }
        self.bringSubviewToFront(topBar)

        //Set the top bar buttons
        var buttonsXPosition: CGFloat = 0
        var buttonNumber = 0
        //Check to see if the top bar will be created with images ot text
        if buttonTitles.count > 0 {
            for item in buttonTitles{
                var barButton: UIButton!
                barButton = UIButton(frame: CGRectMake(buttonsXPosition, 0, width/(CGFloat)(pageCount), topBarHeight))
                barButton.backgroundColor = UIColor.clearColor()
                barButton.setTitle(buttonTitles[buttonNumber], forState: UIControlState.Normal)
                barButton.setTitleColor(tabTextColor, forState: UIControlState.Normal)
                barButton.tag = buttonNumber
                barButton.addTarget(self, action: "barButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
                topBar.addSubview(barButton)
                buttonsXPosition = width/(CGFloat)(pageCount) + buttonsXPosition
                buttonNumber++
            }
        } else {
            for item in buttonImages{
                var barButton: UIButton!
                barButton = UIButton(frame: CGRectMake(buttonsXPosition, 0, width/(CGFloat)(pageCount), topBarHeight))
                barButton.backgroundColor = UIColor.clearColor()
                barButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
                barButton.setImage(item, forState: .Normal)
                barButton.tag = buttonNumber
                barButton.addTarget(self, action: "barButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
                topBar.addSubview(barButton)
                buttonsXPosition = width/(CGFloat)(pageCount) + buttonsXPosition
                buttonNumber++
            }
        }
        
        //Set up the animated UIView
        let count = pageCount == 0 ? 1 : pageCount
        animatedBar = UIView(frame: CGRectMake(0, topBarHeight - animatedBarHeight + 1, (width/(CGFloat)(count))*0.8, animatedBarHeight))
        animatedBar.center.x = width/(CGFloat)(count * 2)
        animatedBar.backgroundColor = tabBarColor
        topBar.addSubview(animatedBar)

        //Defining the content size of the scrollview
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageCount),
            height: pagesScrollViewSize.height)
    }
    
    func initViews (views:[UIViewController], buttonTitlesArray:[String]){
        if views.count == buttonTitlesArray.count {
            pageViews = views
            buttonTitles = buttonTitlesArray
        } else {
            println("Initilization failed, the VC ID array count does not match the button titles array count.")
        }
    }
    
    func initViews (views:[UIViewController], buttonImagesArray:[UIImage]){
        if views.count == buttonImagesArray.count {
            pageViews = views
            buttonImages = buttonImagesArray
        } else {
            println("Initilization failed, the VC ID array count does not match the button images array count.")
        }
    }
    
    func barButtonAction(sender: UIButton?){
        var index: Int = sender!.tag
        let pagesScrollViewSize = scrollView.frame.size
        [scrollView .setContentOffset(CGPointMake(pagesScrollViewSize.width * (CGFloat)(index), 0), animated: true)]
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        var offsetAddition = (self.frame.size.width/(CGFloat)(pageViews.count))*0.1
        animatedBar.frame = CGRectMake((offsetAddition + (scrollView.contentOffset.x/(CGFloat)(pageViews.count))), animatedBar.frame.origin.y, animatedBar.frame.size.width, animatedBar.frame.size.height);
    }
    
}