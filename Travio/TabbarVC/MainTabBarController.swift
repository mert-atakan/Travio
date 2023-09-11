//
//  MainTabBarController.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
    }
    
    func setupTabWithNavigation() {
        
            self.navigationController?.isNavigationBarHidden = true
        
    
        
        let home = UINavigationController(rootViewController: HomeVC())

        
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
         
        let visit = UINavigationController(rootViewController: VisitVC())
        visit.tabBarItem = UITabBarItem(title: "Visit", image: UIImage(named: "visit"), tag: 1)
       
        let map = UINavigationController(rootViewController: MapVC())
        map.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map"), tag: 2)
                                     
        let menu = UINavigationController(rootViewController: MenuVC())
        menu.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "menu"), tag: 3)
        
        self.viewControllers = [home,visit,map,menu]
        
        tabDesign()
       }
    
    func setupTab() {
        
            self.navigationController?.isNavigationBarHidden = true
        
        
        
        let home = HomeVC()
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
         
        let visit = UINavigationController(rootViewController: VisitVC())
        visit.navigationController?.isNavigationBarHidden = true
        visit.tabBarItem = UITabBarItem(title: "Visit", image: UIImage(named: "visit"), tag: 1)
       
        let map = MapVC()
        map.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map"), tag: 2)
                                     
        let menu = MenuVC()
        menu.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "menu"), tag: 3)
        
        self.viewControllers = [home,visit,map,menu]
     
        tabDesign()
       }
    
    func tabDesign() {
        let appereance = UITabBar.appearance()
        appereance.backgroundColor = Color.white.chooseColor
        appereance.unselectedItemTintColor = Color.barItemColor.chooseColor
        appereance.tintColor = Color.systemGreen.chooseColor
    }


}
