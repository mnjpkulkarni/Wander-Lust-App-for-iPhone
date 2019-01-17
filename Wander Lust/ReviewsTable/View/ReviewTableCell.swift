//
//  ReviewCell.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/13/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit

class ReviewTableCell: UITableViewCell {

    private var reviewLbl: UILabel!
    
    func configureCell(reviewData: ReviewData){
        
        reviewLbl = UILabel(frame: CGRect(x: 10, y: 10, width: self.contentView.frame.width - 20, height: self.contentView.frame.height - 20))
        reviewLbl.text = reviewData.text
        reviewLbl.textColor = UIColor.white
        reviewLbl.font = UIFont.boldSystemFont(ofSize: 14)
        reviewLbl.numberOfLines = 8
        self.contentView.addSubview(reviewLbl)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        reviewLbl.text = ""
    }

}
