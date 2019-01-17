//
//  EditProfileVC.swift
//  Wander Lust
//
//  Created by Manoj Kulkarni on 5/4/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit
import Firebase

class EditProfileVC: UIViewController {
    
    var backgroundImg: UIImageView!
    
    var userIdTxt: UITextField!
    var phoneNumberTxt: UITextField!
    var nameTxt: UITextField!
    
     var submitBtn: UIButton!
    
    var userId: String!
    var phoneNumber: String!
    var name:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
    }

    func setUpLayout(){
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundImg.contentMode = .scaleAspectFit
        backgroundImg.image = UIImage(named: "profile_bg")
        self.view.addSubview(backgroundImg)
        
        userIdTxt = UITextField(frame: CGRect(x: self.view.frame.width*0.1, y: 120, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        userIdTxt.backgroundColor = UIColor.white
        userIdTxt.textColor = UIColor.blue
        userIdTxt.alpha = 0.8
        userIdTxt.autocapitalizationType = .none
        userIdTxt.placeholder = "Username"
        userIdTxt.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(userIdTxt)
        
        phoneNumberTxt = UITextField(frame: CGRect(x: self.view.frame.width*0.1, y: 140+userIdTxt.frame.height, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        phoneNumberTxt.backgroundColor = UIColor.white
        phoneNumberTxt.textColor = UIColor.blue
        phoneNumberTxt.alpha = 0.8
        phoneNumberTxt.placeholder = "Phone Number"
        phoneNumberTxt.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(phoneNumberTxt)
        
        nameTxt = UITextField(frame: CGRect(x: self.view.frame.width*0.1, y: 160+userIdTxt.frame.height+phoneNumberTxt.frame.height, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        nameTxt.backgroundColor = UIColor.white
        nameTxt.textColor = UIColor.blue
        nameTxt.alpha = 0.8
        nameTxt.placeholder = "Full Name"
        nameTxt.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(nameTxt)
        
        submitBtn = UIButton(frame: CGRect(x: self.view.frame.width*0.2, y: 180+userIdTxt.frame.height+phoneNumberTxt.frame.height+nameTxt.frame.height, width: self.view.frame.width*0.6, height: self.view.frame.height*0.05))
        submitBtn.setTitle("SUBMIT", for: .normal)
        submitBtn.backgroundColor = UIColor.darkText
        submitBtn.addTarget(self, action: #selector(editBtnPressed(sender:)), for: .touchUpInside)
        submitBtn.alpha = 0.8
        self.view.addSubview(submitBtn)
    }
    
    @objc func editBtnPressed(sender: UIButton!) {
        
        self.name = nameTxt.text
        self.userId = userIdTxt.text
        self.phoneNumber = phoneNumberTxt.text
        
        let user = Auth.auth().currentUser?.uid
        
        let userRef = Database.database().reference().child("users").child(user!)
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            userRef.updateChildValues(["emailId" : self.userId,
                                       "phone": self.phoneNumber,
                                       "name": self.name])
        }
        
        let alert = UIAlertController(title: "Submitted Successfully", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

}
