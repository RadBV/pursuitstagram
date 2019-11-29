//
//  File.swift
//  pursuitstagram
//
//  Created by Radharani Ribas-Valongo on 11/27/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import Foundation
import UIKit

class homeTabBar: UITabBarController {
    
    lazy var homeVC = UINavigationController(rootViewController: HomeVC())
    
    lazy var createVC = UINavigationController(rootViewController: CreateVC())
    
    lazy var profileVC = UINavigationController(rootViewController: ProfileVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
        createVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus.bubble"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person.crop.square"), tag: 2)
        self.viewControllers = [homeVC, createVC, profileVC]
    }
}
