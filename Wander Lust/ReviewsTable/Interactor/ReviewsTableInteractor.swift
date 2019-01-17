//
//  ReviewsTableInteractor.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/14/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import Foundation

protocol ReviewsBusinessLogic: class {
    func makeRequest(url: String)
}

class ReviewsTableInteractor: ReviewsBusinessLogic {
    
    var reviewsArray = [ReviewData]()
    var presenter: ReviewsPresentationLogic?
    
    func makeRequest(url: String) {
        reviewsArray.removeAll()
        if let urlToServer = URL.init(string: url) {
            let task = URLSession.shared.dataTask(with: urlToServer, completionHandler: { (data, response, error) in
                
                if error != nil || data == nil {
                    print(error.debugDescription)
                }
                    
                else {
                    if let jsonArray = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String, AnyObject>]{
                        
                        for jsonObject in jsonArray! {
                            let reviewData = ReviewData(reviewDict: jsonObject)
                            self.reviewsArray.append(reviewData)
                        }
                        DispatchQueue.main.async {
                            //print("Presenter called")
                            self.presenter?.presentFetchedReviews(response: (self.reviewsArray))
                            
                        }
                        
                    }
                }
                
            })
            task.resume()
            
        }
        
    }
}
