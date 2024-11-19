//
//  ViewController.swift
//  Netflix Kids
//
//  Created by Mohammed Saidam on 12/09/2024.
//

import UIKit


class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // The MainTabBarViewController is the containers for all navigation Controllers
                
        // This code that add all viewControllers in MainTabBar
        
        addViewControllersInTabBar()
        
    }
    
    func addViewControllersInTabBar(){
        let viewConHome = UINavigationController(rootViewController: HomeViewController())
        let viewConUpComing = UINavigationController(rootViewController: UpComingViewController())
        let viewConSearch = UINavigationController(rootViewController: SearchViewController())
        let viewConDownloads = UINavigationController(rootViewController: DownloadsViewController())
     
        
        // this is icons
        viewConHome.tabBarItem.image = UIImage(systemName:"house")
        viewConUpComing.tabBarItem.image = UIImage(systemName: "play.circle")
        viewConSearch.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        viewConDownloads.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        // add name tabbar
        viewConHome.title = "Home"
        viewConUpComing.title = "Coming Soon"
        viewConSearch.title = "Search"
        viewConDownloads.title = "Downloads"
        
        
        // for convert dark mode and light mode
        tabBar.tintColor = .label
        
        // add controllers in tabbar
        setViewControllers([viewConHome,viewConUpComing,viewConSearch,viewConDownloads] , animated: true)
    }


}

