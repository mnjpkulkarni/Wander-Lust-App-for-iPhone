//
//  PlaceData.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/14/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import Foundation

class PlaceData {

    
    private var _id: Int!
    private var _name: String!
    private var _address: String!
    private var _category: String!
    private var _location: String!
    private var _lat: Double!
    private var _lon: Double!
    private var _numReviews: Int!
    private var _reviews: String?
    private var _polarity: Int!
    private var _details: String!
    
    
    var reviewArray = [ReviewData]()
    
    var id: Int {
        get {
            if _reviews == nil {
                return 0
            }
            else {
                return _id!
            }
        }
        set {
            _id = newValue
        }
    }
    
    var name: String {
        get {
            if _name == nil {
                return ""
            }
            else {
                return _name!
            }
        }
        set {
            _name = newValue
        }
    }
    
    var address: String {
        get {
            if _address == nil {
                return ""
            }
            else {
                return _address!
            }
        }
        set {
            _address = newValue
        }
    }
    
    var category: String {
        get {
            if _category == nil {
                return ""
            }
            else {
                return _category!
            }
        }
        set {
            _category = newValue
        }
    }
    
    var location: String {
        get {
            if _location == nil {
                return ""
            }
            else {
                return _location!
            }
        }
        set {
            _location = newValue
        }
    }
    
    var reviews: String {
        get {
            if _reviews == nil {
                return ""
            }
            else {
                return _reviews!
            }
        }
        set {
            _reviews = newValue
        }
    }
    
    var numReviews: Int {
        get {
            if _numReviews == nil {
                return 0
            }
            else {
                return _numReviews!
            }
        }
        set {
            _numReviews = newValue
        }
    }
    
    var details: String {
        get {
            if _details == nil {
                return ""
            }
            else {
                return _details!
            }
        }
        set {
                _details = newValue
        }
    }
    
    
    init(placeDict: Dictionary<String, AnyObject>) {
        
        if let id = placeDict["id"] as? Int {
            self._id = id
        }
        
        if let name = placeDict["name"] as? String {
            self._name = name
        }
        
        if let address = placeDict["address"] as? String {
            self._address = address
        }
        
        if let category = placeDict["category"] as? String {
            self._category = category
        }
        
        if let location = placeDict["location"] as? String {
            self._location = location
        }
        
        if let reviews = placeDict["reviews"] as? String {
            self._reviews = reviews
        }
        
        if let details = placeDict["details"] as? String {
            self._details = details
        }
        
        if let numReviews = placeDict["numReviews"] as? Int {
            self._numReviews = numReviews
        }
        
    }

    
    }
    

