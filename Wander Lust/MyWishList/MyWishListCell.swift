//
//  MyWishListCell.swift
//  Wander Lust
//
//  Created by Manoj Kulkarni on 5/2/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit
import Firebase

class MyWishListCell: UITableViewCell {
    
    var nameLbl: UILabel!
    var startDateLbl: UILabel!
    var endDateLbl: UILabel!
    var countLbl: UILabel!
    
    var deleteBtn: UIButton!
    
    var myWishListData: MyWishListData!

    func configureCell(myWishListData: MyWishListData) {
        
        self.myWishListData = myWishListData
        
        nameLbl = UILabel(frame: CGRect(x: 0, y: 10, width: self.contentView.frame.width*0.5, height: self.contentView.frame.height*0.2))
        nameLbl.text = myWishListData.name
        nameLbl.textAlignment = .center
        nameLbl.textColor = UIColor.white
        nameLbl.font = UIFont.italicSystemFont(ofSize: 25)
        self.contentView.addSubview(nameLbl)
        
        deleteBtn = UIButton(frame: CGRect(x: self.contentView.frame.width*0.6, y: 10, width: self.contentView.frame.width*0.3, height: self.contentView.frame.height*0.2))
        deleteBtn.setBackgroundImage(#imageLiteral(resourceName: "delete_icon"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(deleteItem(sender:)), for: .touchUpInside)
        self.contentView.addSubview(deleteBtn)
        
        startDateLbl = UILabel(frame: CGRect(x: self.contentView.frame.width*0.2, y: 20+nameLbl.frame.height, width: self.contentView.frame.width*0.6, height: self.contentView.frame.height*0.2))
        startDateLbl.text = "Arrival: \(myWishListData.startDate)"
        startDateLbl.textColor = UIColor.white
        startDateLbl.font = UIFont.italicSystemFont(ofSize: 16)
        self.contentView.addSubview(startDateLbl)
        
        endDateLbl = UILabel(frame: CGRect(x: self.contentView.frame.width*0.2, y: 30+nameLbl.frame.height+startDateLbl.frame.height, width: self.contentView.frame.width*0.6, height: self.contentView.frame.height*0.2))
        endDateLbl.text = "Departure: \(myWishListData.endDate)"
        endDateLbl.textColor = UIColor.white
        endDateLbl.font = UIFont.italicSystemFont(ofSize: 16)
        self.contentView.addSubview(endDateLbl)
        
        countLbl = UILabel(frame: CGRect(x: self.contentView.frame.width*0.2, y: 40+nameLbl.frame.height+startDateLbl.frame.height+endDateLbl.frame.height, width: self.contentView.frame.width*0.6, height: self.contentView.frame.height*0.2))
        countLbl.text = "No. of bookings: \(myWishListData.count)"
        countLbl.textColor = UIColor.white
        countLbl.font = UIFont.italicSystemFont(ofSize: 16)
        self.contentView.addSubview(countLbl)
    }
    
    @objc func deleteItem(sender: UIButton!) {
        let user = Auth.auth().currentUser?.uid
        let deleteRef = Database.database().reference().child("bookings").child(user!).queryOrdered(byChild: "name").queryEqual(toValue: self.myWishListData.name)
  
        
        deleteRef.observeSingleEvent(of: .value) { (snapshot) in
            if let snaps = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snaps {
                    let ref = Database.database().reference().child("bookings").child(user!).child(snap.key)
                    ref.removeValue()
                }
                let alert = UIAlertController(title: "Item deleted!", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }

        
     
    }
    
    override func prepareForReuse() {
        self.nameLbl.text = ""
        self.startDateLbl.text = ""
        self.endDateLbl.text = ""
        self.countLbl.text = ""
    }

}
