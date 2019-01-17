//
//  PlacesCell.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/14/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit

class PlacesCell: UITableViewCell {

    private var nameLbl: UILabel!
    private var categoryLbl: UILabel!
    private var numOfReviewsLbl: UILabel!

    func configureCell(placeData: PlaceData){
        
        nameLbl = UILabel(frame: CGRect(x: 10, y: 2, width: self.contentView.frame.width-20, height: self.contentView.frame.height*0.3))
        nameLbl.textColor = UIColor.white
        nameLbl.font = UIFont.boldSystemFont(ofSize: 15)
        nameLbl.text = placeData.name
        self.contentView.addSubview(nameLbl)
        
        categoryLbl = UILabel(frame: CGRect(x: 10, y: nameLbl.frame.height+2.5, width: self.contentView.frame.width-20, height: self.contentView.frame.height*0.3))
        categoryLbl.textColor = UIColor.white
        categoryLbl.font = UIFont.boldSystemFont(ofSize: 12)
        categoryLbl.text = "\(placeData.category) in \(placeData.location)"
        self.contentView.addSubview(categoryLbl)
        
        numOfReviewsLbl = UILabel(frame: CGRect(x: 10, y: nameLbl.frame.height+2.8+categoryLbl.frame.height, width: self.contentView.frame.width-20, height: self.contentView.frame.height*0.3))
        numOfReviewsLbl.text = "\(placeData.numReviews) Reviews"
        numOfReviewsLbl.textColor = UIColor.white
        numOfReviewsLbl.font = UIFont.boldSystemFont(ofSize: 10)
        self.contentView.addSubview(numOfReviewsLbl)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLbl.text = ""
        categoryLbl.text = ""
        numOfReviewsLbl.text = ""
    }

}
