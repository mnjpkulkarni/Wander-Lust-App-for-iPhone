//
//  WishListVC.swift
//  Wander Lust
//
//  Created by Manoj Kulkarni on 4/28/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit
import Firebase

class WishListVC: UIViewController{

    var placeData: PlaceData!
    var backGroundImg: UIImageView!
    var startDateTxt: UITextView!
    var endDateTxt: UITextView!
    
    var startDatePicker: UIDatePicker!
    var endDatePicker: UIDatePicker!
    
    var startDateLbl: UILabel!
    var endDateLbl: UILabel!
    
    var submitBtn: UIButton!
    
    var bookingCntTxt: UITextField!
    
    var startDate: String!
    var endDate: String!
    var numberOfBookings: String!
    
    var userRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        setUpLayout()
    }
    
    func setUpLayout(){
        
        backGroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backGroundImg.image = UIImage(named: "hotel_bg")
        backGroundImg.contentMode = .scaleAspectFill
        self.view.addSubview(backGroundImg)
        
        startDateLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.1, y: 100, width: self.view.frame.width*0.8, height: self.view.frame.height*0.05))
        startDateLbl.text = "Please enter the arrival date."
        startDateLbl.textColor = UIColor.black
        startDateLbl.backgroundColor = UIColor.brown
        startDateLbl.alpha = 0.8
        startDateLbl.textAlignment = .center
        startDateLbl.font = UIFont.boldSystemFont(ofSize: 20)
        self.backGroundImg.addSubview(startDateLbl)
        
        let startDatePickerHeight = 120+startDateLbl.frame.height
        
        startDatePicker = UIDatePicker(frame: CGRect(x: self.view.frame.width*0.1, y: startDatePickerHeight, width: self.view.frame.width*0.8, height: 100))
        startDatePicker.datePickerMode = .dateAndTime
        startDatePicker.alpha = 0.8
        startDatePicker.addTarget(self, action: #selector(startDateSelected(sender:)), for: .valueChanged)
        startDatePicker.backgroundColor = UIColor.gray
        self.view.addSubview(startDatePicker)
        
        let endDateLblHeight = 20+startDatePickerHeight+startDatePicker.frame.height

        endDateLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.1, y: endDateLblHeight, width: self.view.frame.width*0.8, height: self.view.frame.height*0.05))
        endDateLbl.text = "Please enter the departure date."
        endDateLbl.textColor = UIColor.black
        endDateLbl.backgroundColor = UIColor.brown
        endDateLbl.alpha = 0.8
        endDateLbl.textAlignment = .center
        endDateLbl.font = UIFont.boldSystemFont(ofSize: 20)
        self.backGroundImg.addSubview(endDateLbl)

        let endDatePickerHeight = endDateLblHeight+20+endDateLbl.frame.height
        
        endDatePicker = UIDatePicker(frame: CGRect(x: self.view.frame.width*0.1, y: endDatePickerHeight, width: self.view.frame.width*0.8, height: 100))
        endDatePicker.datePickerMode = .dateAndTime
        endDatePicker.alpha = 0.8
        endDatePicker.addTarget(self, action: #selector(endDateSelected(sender:)), for: .valueChanged)
        endDatePicker.backgroundColor = UIColor.gray
        self.view.addSubview(endDatePicker)
        
        let bookingCntTxtHeight = 20+endDatePickerHeight+endDatePicker.frame.height
        
        bookingCntTxt = UITextField(frame: CGRect(x: self.view.frame.width*0.1, y: bookingCntTxtHeight, width: self.view.frame.width*0.8, height: self.view.frame.height*0.1))
        bookingCntTxt.backgroundColor = UIColor.gray
        bookingCntTxt.alpha = 0.9
        bookingCntTxt.placeholder = "Number of reservations."
        bookingCntTxt.textColor = UIColor.white
        bookingCntTxt.font = UIFont.boldSystemFont(ofSize: 22)
        self.view.addSubview(bookingCntTxt)
        
        let submitBtnHeight = 40+endDatePickerHeight+endDatePicker.frame.height+bookingCntTxt.frame.height
        
        submitBtn = UIButton(frame: CGRect(x: self.view.frame.width*0.2, y: submitBtnHeight, width: self.view.frame.width*0.6, height: self.view.frame.height*0.05))
        submitBtn.setTitle("SUBMIT", for: .normal)
        submitBtn.backgroundColor = UIColor.darkText
        submitBtn.addTarget(self, action: #selector(submitBtnPressed(sender:)), for: .touchUpInside)
        submitBtn.alpha = 0.8
        self.view.addSubview(submitBtn)
        

    }
    
    
    @objc func startDateSelected(sender: UIDatePicker!) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd hh:mm"
        self.startDate = formatter.string(from: sender.date)
    }
    
    @objc func endDateSelected(sender: UIDatePicker!) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd hh:mm"
        self.endDate = formatter.string(from: sender.date)
    }
    
    
    @objc func submitBtnPressed(sender: UIButton!) {
        
        numberOfBookings = bookingCntTxt.text
        
        let user = Auth.auth().currentUser?.uid
        userRef = Database.database().reference().child("bookings").child(user!)
  
        let key = self.userRef.childByAutoId().key
        let booking = ["name":self.placeData.name,
                        "id":self.placeData.id,
                        "startDate":self.startDate,
                        "endDate":self.endDate,
        "count":self.numberOfBookings] as [String : Any]
        self.userRef.child(key).setValue(booking)
        
        let alert = UIAlertController(title: "Added to Wishlist", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }

    

}
