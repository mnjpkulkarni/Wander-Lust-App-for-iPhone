//
//  ReviewTableInteractor.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/13/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import Foundation
import UIKit


protocol PlacesBusinessLogic: class {
    func makeRequest(url: String)
}

protocol PlacesDataStore: class {
    var reviewArray: [ReviewData] {get}
}

class PlacesTableInteractor: PlacesBusinessLogic {
    
    var placeArray = [PlaceData]()

    var presenter: PlacesPresentationLogic?

    func makeRequest(url: String) {
        placeArray.removeAll()
        if let urlToServer = URL.init(string: url) {
            let task = URLSession.shared.dataTask(with: urlToServer, completionHandler: { (data, response, error) in
                
                if error != nil || data == nil {
                    print(error.debugDescription)
                }
                    
                else {
                    if let jsonArray = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String, AnyObject>]{
                        
                        for jsonObject in jsonArray! {
                            let placeData = PlaceData(placeDict: jsonObject)
                            self.placeArray.append(placeData)
                        }
                        DispatchQueue.main.async {
                            self.presenter?.presentFetchedReviews(response: (self.placeArray))
                        }
                        
                    }
                }
                
            })
            task.resume()
            
        }
    }
    

}
