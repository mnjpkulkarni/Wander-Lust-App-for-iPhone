//
//  MyWishListData.swift
//  Wander Lust
//
//  Created by Manoj Kulkarni on 5/2/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import Foundation

class MyWishListData {
    
    private var _id: Int!
    private var _name: String!
    private var _startDate: String!
    private var _endDate: String!
    private var _count: String!
    
    var id: Int {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var startDate: String {
        get {
            return _startDate
        }
        set {
            _startDate = newValue
        }
    }
    
    var endDate: String {
        get {
            return _endDate
        }
        set {
            _endDate = newValue
        }
    }
    
    var count: String {
        get {
            return _count
        }
        set {
            _count = newValue
        }
    }
    
    init(wishListDict: Dictionary<String, AnyObject>) {
        
        if let id = wishListDict["id"] as? Int {
            self._id = id
        }
        
        if let name = wishListDict["name"] as? String {
            self._name = name
        }
        
        if let startDate = wishListDict["startDate"] as? String {
            self._startDate = startDate
        }
        
        if let endDate = wishListDict["endDate"] as? String {
            self._endDate = endDate
        }
        
        if let count = wishListDict["count"] as? String {
            self._count = count
        }
        
        print(name)
    }
    
}
