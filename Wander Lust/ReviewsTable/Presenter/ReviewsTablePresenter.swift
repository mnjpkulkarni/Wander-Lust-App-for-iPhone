//
//  ReviewsTablePresenter.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/14/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import Foundation

protocol ReviewsPresentationLogic: class {
    func presentFetchedReviews(response: [ReviewData])
}

class ReviewsTablePresenter: ReviewsPresentationLogic {
    
    var viewController: ReviewsDisplayLogic?
    
    func presentFetchedReviews(response: [ReviewData]) {
        //print("Viewcontroller called")
        self.viewController?.displayTable(reviewsArray: response)
}

}
