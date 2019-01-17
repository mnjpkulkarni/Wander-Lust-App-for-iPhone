//
//  ReviewTableProtocol.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/13/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import Foundation
import UIKit


protocol PresenterToViewProtocol: class {
    func showReviews()
    func showError()
}

protocol InteractorToPresenterProtocol: class{
    func reviewFetched(reviewArray: [ReviewData])
    func reviewFetchingFailed()
}

protocol PresentorToInterectorProtocol: class{
    func fetchReviews()
}

protocol ViewToPresenterProtocol: class{
  func updateView()
}

protocol PresenterToRouterProtocol: class{
    
}
