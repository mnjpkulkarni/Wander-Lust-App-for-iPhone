//
//  ReviewTablePresenter.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/13/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import Foundation
import UIKit

protocol PlacesPresentationLogic: class {
    func presentFetchedReviews(response: [PlaceData])
}

class PlacesTablePresenter: PlacesPresentationLogic {

    var viewController: PlacesDisplayLogic?
    
    func presentFetchedReviews(response: [PlaceData]) {
        self.viewController?.displayTable(placeArray: response)
    }

    
    
}
