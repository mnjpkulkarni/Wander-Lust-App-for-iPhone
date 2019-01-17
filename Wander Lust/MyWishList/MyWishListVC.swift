//
//  MyWishListVC.swift
//  Wander Lust
//
//  Created by Manoj Kulkarni on 5/2/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit
import Firebase

class MyWishListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var backgroundImg: UIImageView!
    
    var tableView: UITableView!
    
    var myWishListArray = [MyWishListData]()
    
    var wishListRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        //downloadData()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.myWishListArray.removeAll()
        downloadData()
    }
    
    func setUpLayout() {
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundImg.image = UIImage(named: "wishlist_bg")
        self.view.addSubview(backgroundImg)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alpha = 0.7
        tableView.register(MyWishListCell.self, forCellReuseIdentifier: "wishlist_cell")
        self.view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myWishListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "wishlist_cell", for: indexPath) as? MyWishListCell {
            if indexPath.row%2 == 0 {
                cell.backgroundColor = UIColor.black
            }
            else {
                cell.backgroundColor = UIColor.darkGray
            }
            cell.configureCell(myWishListData: self.myWishListArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func downloadData() {
        
        let user = Auth.auth().currentUser?.uid
        
        wishListRef = Database.database().reference().child("bookings").child(user!)
        
        wishListRef.observeSingleEvent(of: .value) { (snapshot) in
            if let snaps = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snaps {
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        let myWishListData = MyWishListData(wishListDict: dict)
                        self.myWishListArray.append(myWishListData)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func refreshTableView(sender: UIBarButtonItem!) {
        self.myWishListArray.removeAll()
        downloadData()
        self.tableView.reloadData()
    }


}
