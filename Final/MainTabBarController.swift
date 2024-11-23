//
//  MainTabBarController.swift
//  Final
//
//  Created by Eva H on 11/21/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create instances of each view controller
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let historyVC = HistoryViewController()
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "clock"), tag: 1)

        let profileVC = ViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)

        // Embed each view controller in a UINavigationController
        let homeNav = UINavigationController(rootViewController: homeVC)
        let historyNav = UINavigationController(rootViewController: historyVC)
        let profileNav = UINavigationController(rootViewController: profileVC)

        // Add all navigation controllers to the tab bar
        self.viewControllers = [homeNav, historyNav, profileNav]
        
        // Customize tab bar appearance (optional)
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .gray
        tabBar.barTintColor = .white
    }
}
