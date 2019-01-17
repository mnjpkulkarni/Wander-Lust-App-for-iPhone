//
//  MyProfileVC.swift
//  Wander Lust
//
//  Created by Manoj Kulkarni on 5/3/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit
import Firebase

class MyProfileVC: UIViewController {
    
    var profileImg: UIImageView!
    var nameLbl: UILabel!
    var emailLbl: UILabel!
    var phoneLbl: UILabel!
    
    var backgroundImg: UIImageView!
    
    var name: String!
    var email: String!
    var phone: String!
    
    var editProfileBtn: UIButton!
    
    var imgRef: StorageReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
        downloadData()
    }


    func setUpLayout() {
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundImg.image = UIImage(named: "profile_bg")
        backgroundImg.contentMode = .scaleAspectFit
        self.view.addSubview(backgroundImg)
        
        profileImg = UIImageView(frame: CGRect(x: self.view.frame.width*0.1, y: 100, width: self.view.frame.width*0.8, height: self.view.frame.height*0.3))
        profileImg.contentMode = .scaleAspectFit
        self.backgroundImg.addSubview(profileImg)
        
        nameLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.1, y: 400, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        nameLbl.textColor = UIColor.white
        nameLbl.font = UIFont.boldSystemFont(ofSize: 22)
        self.view.addSubview(nameLbl)
        
        emailLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.1, y: 420+nameLbl.frame.height, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        emailLbl.textColor = UIColor.white
        emailLbl.font = UIFont.boldSystemFont(ofSize: 22)
        self.view.addSubview(emailLbl)
        
        phoneLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.1, y: 440+nameLbl.frame.height+emailLbl.frame.height, width: self.view.frame.width*0.8, height: self.view.frame.height*0.08))
        phoneLbl.textColor = UIColor.white
        phoneLbl.font = UIFont.boldSystemFont(ofSize: 22)
        self.view.addSubview(phoneLbl)
        
        editProfileBtn = UIButton(frame: CGRect(x: self.view.frame.width*0.4, y:  460+nameLbl.frame.height+emailLbl.frame.height+phoneLbl.frame.height, width: self.view.frame.width*0.2, height: self.view.frame.height*0.08))
        editProfileBtn.addTarget(self, action: #selector(editProfile(sender:)), for: .touchUpInside)
        editProfileBtn.setBackgroundImage(#imageLiteral(resourceName: "edit-document"), for: .normal)
        self.view.addSubview(editProfileBtn)
        
    }
    
    func downloadData(){
        
        let user = Auth.auth().currentUser?.uid
        
        let userRef = Database.database().reference().child("users").child(user!)
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, AnyObject> {
                if let emailId = dict["emailId"] as? String {
                    self.email = emailId
                }
                if let phone = dict["phone"] as? String {
                    self.phone = phone
                }
                if let name = dict["name"] as? String {
                    self.name = name
                }
            }
            
            DispatchQueue.main.async {
                self.nameLbl.text = "Name: \(self.name!)"
                self.emailLbl.text = "Email: \(self.email!)"
                self.phoneLbl.text = "Phone: \(self.phone!)"
            }
        }
        
        imgRef = Storage.storage().reference(forURL: "gs://wander-lust-2dbe5.appspot.com/\(user!).img")
        imgRef.getData(maxSize: 15 * 1024 * 1024) { (data, error) in
            if error != nil {
                print(error.debugDescription)
                print(error?.localizedDescription)
            }
            else {
                let img = UIImage(data: data!)
                self.profileImg.image = img
            }
        }
        
    }
    
    @objc func editProfile(sender: UIButton!) {
        let editProfileVC = EditProfileVC()
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }

}
