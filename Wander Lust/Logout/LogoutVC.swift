//
//  LogoutVC.swift
//  Wander Lust
//
//  Created by Manoj Kulkarni on 5/4/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit

class LogoutVC: UIViewController {
    
    var backgroundImg: UIImageView!
    var loginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
    }

    func setUpLayout() {
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundImg.image = UIImage(named: "thanks_bg")
        backgroundImg.contentMode = .scaleAspectFit
        self.view.addSubview(backgroundImg)
        
        loginBtn = UIButton(frame: CGRect(x: self.view.frame.width*0.1, y: 200, width: self.view.frame.width*0.8, height: self.view.frame.width*0.2))
        loginBtn.setTitle("Login Again", for: .normal)
        loginBtn.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        loginBtn.backgroundColor = UIColor.black
        self.view.addSubview(loginBtn)
        

    }
    
    @objc func login(sender: UIButton!) {
        let loginVC = LoginVC()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

}
