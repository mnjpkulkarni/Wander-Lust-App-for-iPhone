//
//  RegisterVC.swift
//  Wander Lust
//
//  Created by Manoj Kulkarni on 4/29/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class RegisterVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var backgroundImg: UIImageView!
    
    var userIdTxt: UITextField!
    var passwordTxt: UITextField!
    var phoneNumberTxt: UITextField!
    var nameTxt: UITextField!
    
    var submitBtn: UIButton!
    var profilePicBtn: UIButton!
    
    var profileImg: UIImage?
    
    var userId: String!
    var password: String!
    var phoneNumber: String!
    var name:String!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("users")
        setUpLayout()
    }
    
    func setUpLayout(){
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundImg.image = UIImage(named: "register_bg")
        backgroundImg.alpha = 0.8
        self.view.addSubview(backgroundImg)
        
        userIdTxt = UITextField(frame: CGRect(x: self.view.frame.width*0.1, y: 100, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        userIdTxt.backgroundColor = UIColor.white
        userIdTxt.textColor = UIColor.blue
        userIdTxt.alpha = 0.8
        userIdTxt.autocapitalizationType = .none
        userIdTxt.placeholder = "Username"
        userIdTxt.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(userIdTxt)
        
        passwordTxt = UITextField(frame: CGRect(x: self.view.frame.width*0.1, y: 120+userIdTxt.frame.height, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        passwordTxt.backgroundColor = UIColor.white
        passwordTxt.textColor = UIColor.blue
        passwordTxt.alpha = 0.8
        passwordTxt.placeholder = "Password"
        passwordTxt.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(passwordTxt)
        
        phoneNumberTxt = UITextField(frame: CGRect(x: self.view.frame.width*0.1, y: 140+userIdTxt.frame.height+passwordTxt.frame.height, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        phoneNumberTxt.backgroundColor = UIColor.white
        phoneNumberTxt.textColor = UIColor.blue
        phoneNumberTxt.alpha = 0.8
        phoneNumberTxt.placeholder = "Phone Number"
        phoneNumberTxt.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(phoneNumberTxt)
        
        nameTxt = UITextField(frame: CGRect(x: self.view.frame.width*0.1, y: 160+userIdTxt.frame.height+passwordTxt.frame.height+phoneNumberTxt.frame.height, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        nameTxt.backgroundColor = UIColor.white
        nameTxt.textColor = UIColor.blue
        nameTxt.alpha = 0.8
        nameTxt.placeholder = "Full Name"
        nameTxt.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(nameTxt)
        
        profilePicBtn = UIButton(frame: CGRect(x: self.view.frame.width*0.4, y: 180+userIdTxt.frame.height+passwordTxt.frame.height+phoneNumberTxt.frame.height+nameTxt.frame.height, width: self.view.frame.width*0.2, height: self.view.frame.height*0.05))
        profilePicBtn.setBackgroundImage(#imageLiteral(resourceName: "image_picker"), for: .normal)
        profilePicBtn.setTitle("Pic", for: .normal)
        profilePicBtn.backgroundColor = UIColor.darkText
        profilePicBtn.addTarget(self, action: #selector(uploadImg(sender:)), for: .touchUpInside)
        profilePicBtn.alpha = 0.8
        self.view.addSubview(profilePicBtn)
        
        submitBtn = UIButton(frame: CGRect(x: self.view.frame.width*0.2, y: 260+userIdTxt.frame.height+passwordTxt.frame.height+phoneNumberTxt.frame.height+nameTxt.frame.height+profilePicBtn.frame.height, width: self.view.frame.width*0.6, height: self.view.frame.height*0.05))
        submitBtn.setTitle("REGISTER", for: .normal)
        submitBtn.backgroundColor = UIColor.darkText
        submitBtn.addTarget(self, action: #selector(registerBtnPressed(sender:)), for: .touchUpInside)
        submitBtn.alpha = 0.8
        self.view.addSubview(submitBtn)
        
    }
    
    @objc func registerBtnPressed(sender: UIButton!) {
        
        userId = userIdTxt.text
        password = passwordTxt.text
        phoneNumber = phoneNumberTxt.text
        name = nameTxt.text
        
        
        
        if userId == "" || password == "" {
            print("Enter Credentials")
            return
        }
        
        else {
            Auth.auth().createUser(withEmail: userId, password: password, completion: { (user, error) in
                if user != nil {
                    let uid = Auth.auth().currentUser?.uid
                    let storageRef = Storage.storage().reference().child("\(uid!).img")
                    if let imageData = UIImagePNGRepresentation(self.profileImg!) {
                        storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            }
                            else {
                                print(metadata)
                            }
                        })
                    }
                    
                    let key = self.ref.childByAutoId().key
                    let userDetails = ["emailId":self.userId,
                                       "password":self.password,
                                       "phone":self.phoneNumber,
                                       "name":self.name]
                    self.ref.child(uid!).setValue(userDetails)
                    
                    let alert = UIAlertController(title: "User Created Successfully", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
        }
        
        
    }
    
    @objc func uploadImg(sender: UIButton!) {
        let img = UIImagePickerController()
        img.delegate = self
        img.sourceType = .photoLibrary
        img.allowsEditing = true
        self.present(img, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImg: UIImage?
        
        if let originalImg = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImg = originalImg
            profileImg = originalImg
        }
        
        dismiss(animated: true, completion: nil)
        
    }


}
