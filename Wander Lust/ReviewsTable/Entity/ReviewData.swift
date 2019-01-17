//
//  ReviewData.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/13/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import Foundation

class ReviewData {
    
    private var _language: String!
    private var _polarity: Int!
    private var _rating: Int!
    private var _source: String!
    private var _text: String!
    private var _time: String!
    private var _wordsCount: Int!
    private var _details: String!
    
    
    var language: String {
        get {
            if _language == nil {
                return ""
            }
            else {
                return _language!
            }
        }
        set {
            self._language = newValue
        }
    }
    
    var polarity: Int {
        get {
            if _polarity == nil {
                return 0
            }
            else {
                return _polarity!
            }
        }
        set {
            self._polarity = newValue
        }
    }
    
    var rating: Int {
        get {
            if _rating == nil {
                return 0
            }
            else {
                return _rating!
            }
        }
        set {
            self._rating = newValue
        }
    }
    
    var source: String {
        get {
            if _source == nil {
                return ""
            }
            else {
                return _source!
            }
        }
        set {
            self._source = newValue
        }
    }
    
    var text: String {
        get {
            if _text == nil {
                return ""
            }
            else {
                return _text!
            }
        }
        set {
            self._text = newValue
        }
    }
    
    var time: String {
        get {
            if _time == nil {
                return ""
            }
            else {
                return _time!
            }
        }
        set {
            self._time = newValue
        }
    }
    
    var wordsCount: Int {
        get {
            if _wordsCount == nil {
                return 0
            }
            else {
                return _wordsCount!
            }
        }
        set {
            self._wordsCount = newValue
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
            self._details = newValue
        }
    }
    
    
    //Initializer
    
    init(reviewDict: Dictionary<String, AnyObject>) {
        
        if let language = reviewDict["language"] as? String {
            self.language = language
        }
        
        if let polarity = reviewDict["polarity"] as? Int {
            self.polarity = polarity
        }
        
        if let rating = reviewDict["rating"] as? Int {
            self.rating = rating
        }
        
        if let source = reviewDict["source"] as? String {
            self.source = source
        }
        
        if let text = reviewDict["text"] as? String {
            self.text = text
        }
        
        if let time = reviewDict["time"] as? String {
            self.time = time
        }
        
        if let wordsCount = reviewDict["wordsCount"] as? Int {
            self.wordsCount = wordsCount
        }
        
        if let details = reviewDict["details"] as? String {
            self.details = details
        }
    }

}
