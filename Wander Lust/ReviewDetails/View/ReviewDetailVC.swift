//
//  ReviewDetailVC.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/14/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit

class ReviewDetailVC: UIViewController {
    
    var reviewData: ReviewData!
    
    var reviewLbl: UILabel!
    var polarityLbl: UILabel!
    var ratingLbl: UILabel!
    var sourceLbl: UILabel!
    var timeLbl: UILabel!
    var detailsLbl: UILabel!
    
    var backgroundImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        setUpLayout()
    }
    
    func setUpLayout() {
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundImg.contentMode = .scaleAspectFit
        backgroundImg.image = UIImage(named: "restaurant_bg")
        backgroundImg.alpha = 0.6
        self.view.addSubview(backgroundImg)
        
        reviewLbl = UILabel(frame: CGRect(x: 10, y: self.view.frame.height*0.12, width: self.view.frame.width-20, height: self.view.frame.height*0.25))
        reviewLbl.textColor = UIColor.white
        reviewLbl.text = reviewData.text
        reviewLbl.font = UIFont.boldSystemFont(ofSize: 15)
        reviewLbl.numberOfLines = 8
        self.view.addSubview(reviewLbl)
        
        polarityLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.3, y: (self.view.frame.height*0.12)+reviewLbl.frame.height+0.1, width: self.view.frame.width*0.4, height: self.view.frame.height*0.08))
        polarityLbl.textColor = UIColor.white
        polarityLbl.textAlignment = .center
        polarityLbl.text = "Polarity : \(reviewData.polarity)"
        polarityLbl.font = UIFont.boldSystemFont(ofSize: 15)
        polarityLbl.numberOfLines = 1
        self.view.addSubview(polarityLbl)
        
        ratingLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.3, y: (self.view.frame.height*0.12)+reviewLbl.frame.height+0.1+(polarityLbl.frame.height), width: self.view.frame.width*0.4, height: self.view.frame.height*0.08))
        ratingLbl.textColor = UIColor.white
        ratingLbl.textAlignment = .center
        ratingLbl.text = "Rating : \(reviewData.rating)"
        ratingLbl.font = UIFont.boldSystemFont(ofSize: 15)
        ratingLbl.numberOfLines = 1
        self.view.addSubview(ratingLbl)
        
        let sourceTopConstraint = (self.view.frame.height*0.12)+reviewLbl.frame.height+0.1+(polarityLbl.frame.height)+(ratingLbl.frame.height)
        
        sourceLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.3, y: sourceTopConstraint, width: self.view.frame.width*0.4, height: self.view.frame.height*0.08))
        sourceLbl.textColor = UIColor.white
        sourceLbl.textAlignment = .center
        sourceLbl.text = "Source : \(reviewData.source)"
        sourceLbl.font = UIFont.boldSystemFont(ofSize: 15)
        sourceLbl.numberOfLines = 1
        self.view.addSubview(sourceLbl)
        
        let timeTopConstraint = sourceTopConstraint+(sourceLbl.frame.height)
        
        timeLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.3, y: timeTopConstraint, width: self.view.frame.width*0.4, height: self.view.frame.height*0.08))
        sourceLbl.textColor = UIColor.white
        sourceLbl.textAlignment = .center
        sourceLbl.text = "Time : \(reviewData.time)"
        sourceLbl.font = UIFont.boldSystemFont(ofSize: 15)
        sourceLbl.numberOfLines = 1
        self.view.addSubview(timeLbl)
        
        let detailTopConstraint = timeTopConstraint+(timeLbl.frame.height)
        
        detailsLbl = UILabel(frame: CGRect(x: self.view.frame.width*0.1, y: detailTopConstraint, width: self.view.frame.width*0.8, height: self.view.frame.height*0.15))
        detailsLbl.textColor = UIColor.white
        detailsLbl.textAlignment = .center
        detailsLbl.text = "Details : \(reviewData.details)"
        detailsLbl.font = UIFont.boldSystemFont(ofSize: 15)
        detailsLbl.numberOfLines = 5
        
        self.view.addSubview(detailsLbl)
        
        
    }


}
