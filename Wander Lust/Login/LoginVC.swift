//
//  LoginVC.swift
//  Wander Lust
//
//  Created by Manoj Kulkarni on 4/29/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController, UITextFieldDelegate {
    
    var backgroundImg: UIImageView!
    
    var userIdTxt: UITextField!
    var passwordTxt: UITextField!
    
    var submitBtn: UIButton!
    var registerBtn: UIButton!
    
    var userId: String!
    var password: String!
    
    var registerLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Wander Lust"
        setUpLayout()
    }
    
    func setUpLayout(){
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundImg.image = UIImage(named: "login_bg")
        backgroundImg.alpha = 0.8
        self.view.addSubview(backgroundImg)
        
        userIdTxt = UITextField(frame: CGRect(x: self.view.frame.width*0.1, y: 200, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        userIdTxt.backgroundColor = UIColor.white
        userIdTxt.textColor = UIColor.black
        userIdTxt.alpha = 0.8
        userIdTxt.textAlignment = .center
        userIdTxt.delegate = self
        userIdTxt.placeholder = "Username"
        userIdTxt.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(userIdTxt)
        
        passwordTxt = UITextField(frame: CGRect(x: self.view.frame.width*0.1, y: 220+userIdTxt.frame.height, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        passwordTxt.backgroundColor = UIColor.white
        passwordTxt.textColor = UIColor.black
        passwordTxt.delegate = self
        passwordTxt.alpha = 0.8
        passwordTxt.textAlignment = .center
        passwordTxt.isSecureTextEntry = true
        passwordTxt.placeholder = "Password"
        passwordTxt.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(passwordTxt)
        
        submitBtn = UIButton(frame: CGRect(x: self.view.frame.width*0.2, y: 240+userIdTxt.frame.height+passwordTxt.frame.height, width: self.view.frame.width*0.6, height: self.view.frame.height*0.05))
        submitBtn.setTitle("SIGN IN", for: .normal)
        submitBtn.backgroundColor = UIColor.darkText
        submitBtn.addTarget(self, action: #selector(loginBtnPressed(sender:)), for: .touchUpInside)
        submitBtn.alpha = 0.8
        self.view.addSubview(submitBtn)
        
        let registerLblHeight = 400+userIdTxt.frame.height+passwordTxt.frame.height+submitBtn.frame.height
        
        registerLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.1, y: registerLblHeight, width: self.view.frame.width*0.8, height: self.view.frame.height*0.05))
        registerLbl.text = "Not one of us? Sign Up below!"
        registerLbl.textColor = UIColor.black
        registerLbl.font = UIFont.italicSystemFont(ofSize: 22)
        self.view.addSubview(registerLbl)
        
        let registerBtnHeight = 420+userIdTxt.frame.height+passwordTxt.frame.height+submitBtn.frame.height+registerLbl.frame.height
        
        registerBtn = UIButton(frame: CGRect(x: self.view.frame.width*0.2, y: registerBtnHeight, width: self.view.frame.width*0.6, height: self.view.frame.height*0.05))
        registerBtn.setTitle("Register", for: .normal)
        registerBtn.backgroundColor = UIColor.brown
        registerBtn.alpha = 0.9
        registerBtn.addTarget(self, action: #selector(registerBtnPressed(sender:)), for: .touchUpInside)
        self.view.addSubview(registerBtn)
        
    }
    
    @objc func loginBtnPressed(sender: UIButton!){

        userId = userIdTxt.text
        password = passwordTxt.text
        
        if userId != "" || password != "" {
            Auth.auth().signIn(withEmail: userId, password: password, completion: { (user, error) in
                
                if user != nil {
//                    let placesTableVC = PlacesTableVC()
//                    self.navigationController?.pushViewController(placesTableVC, animated: true)
                    
                    let homeScreenVC = HomeScreenVC()
                    self.navigationController?.pushViewController(homeScreenVC, animated: true)

                }
            })
        }
        
    }
    
    @objc func registerBtnPressed(sender: UIButton!){
        let registerVC = RegisterVC()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    

}
