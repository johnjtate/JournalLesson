//
//  Entry.swift
//  Journal
//
//  Created by John Tate on 8/22/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class Entry: Equatable, Codable {
    
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        if lhs.timestamp != rhs.timestamp { return false }
        if lhs.title != rhs.title { return false }
        if lhs.bodytext != rhs.bodytext { return false }
        return true
    }
    
    var timestamp: Date
    var title: String
    var bodytext: String = ""
    
    init(timestamp: Date = Date(), title: String, bodytext: String) {
        self.timestamp = timestamp
        self.title = title
        self.bodytext = bodytext
    }
}

