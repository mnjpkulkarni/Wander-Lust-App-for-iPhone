//
//  HomeScreenVC.swift
//  Wander Lust
//
//  Created by Manoj Kulkarni on 5/1/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit
import Firebase

class HomeScreenVC: UITabBarController {
    
    var logOutBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()

    }
    
    func setUpLayout() {
        
        logOutBtn = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logOut(sender:)))
        self.navigationItem.rightBarButtonItem = logOutBtn
        
        let placesVC = PlacesTableVC()
        placesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        let myWishListVC = MyWishListVC()
        myWishListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let myProfileVC = MyProfileVC()
        myProfileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        self.viewControllers = [placesVC, myWishListVC, myProfileVC]
    }
    
    @objc func logOut(sender: UIButton!) {
        do {
            try Auth.auth().signOut()
        }
        catch let error as Error {
            print(error.localizedDescription)
        }
        
        let logoutVC = LogoutVC()
        self.navigationController?.pushViewController(logoutVC, animated: true)
        
    }



}
