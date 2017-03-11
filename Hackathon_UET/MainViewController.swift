//
//  MainViewController.swift
//  Hackathon_UET
//
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Alamofire
import CarbonKit

class MainViewController: UIViewController {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var mainView : UIView!
    static let sharedInstance = MainViewController()
    var slideMenu : SlideMenuController?
    var tabsName = [String]()
    @IBOutlet weak var contentView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        initCarbonTabs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMenuTouchUpInSide(_ sender: Any) {
        if (MainViewController.sharedInstance.slideMenu?.slideMenuController()?.isLeftOpen())! {
            MainViewController.sharedInstance.slideMenu?.slideMenuController()?.closeLeft()
        } else {
            MainViewController.sharedInstance.slideMenu?.slideMenuController()?.openLeft()
        }
    }
    
    func initViewControllers() {
//        screenerController = self.storyboard?.instantiateViewControllerWithIdentifier("ScreenerViewController") as! ScreenerViewController
    }
    
    func initCarbonTabs() {
        tabsName.append("What's new")
        tabsName.append("Favorite Posts")
        tabsName.append("My Posts")
        tabsName.append("My Tag")
        tabsName.append("Popular Users")
        tabsName.append("Setting")
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: tabsName, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: contentView)
        carbonTabSwipeNavigation.toolbar.isTranslucent = false
        carbonTabSwipeNavigation.setTabBarHeight(40)
        carbonTabSwipeNavigation.setIndicatorHeight(0)
        carbonTabSwipeNavigation.carbonSegmentedControl?.backgroundColor = UIColor.init(rgba: "#FAFAFA")
        carbonTabSwipeNavigation.setNormalColor(UIColor.init(rgba: "#040D14"), font: UIFont.boldSystemFont(ofSize: 13))
        carbonTabSwipeNavigation.setNormalColor(UIColor.init(rgba: "#007D01"), font: UIFont.boldSystemFont(ofSize: 14))
        for i in 0..<tabsName.count {
            carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(UIScreen.main.bounds.width / 3, forSegmentAt: i)
        }
    }
    
    

}
extension MainViewController : CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        var str = ""
        switch index {
        case 0:
            str = "What's new"
        case 1:
            str = "Favorites Post"
        case 2:
            str = "My Posts"
        case 3 :
            str = "My Tag"
        case 4:
            str = "Popular Users"
        default:
            str = "Setting"
        }
        //self.lblTitle.text = str
    }
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            let vc = WhatNewsViewController(nibName: "WhatNewsViewController", bundle: nil)
            return vc
        case 1:
            let vc = WhatNewsViewController(nibName: "WhatNewsViewController", bundle: nil)
            //vc.urlRequest = URL_DEFINE.
            return vc
        case 2:
            let vc = WhatNewsViewController(nibName: "WhatNewsViewController", bundle: nil)
            vc.urlRequest = URL_DEFINE.home_post
            return vc
        case 3:
            let vc = MyTagViewController(nibName: "MyTagViewController", bundle: nil)
            return vc
        default :
            let vc = PopularUserViewController(nibName: "PopularUserViewController", bundle: nil)
            return vc        
        }
    }
}
