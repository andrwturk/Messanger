//
//  MessageEntry.swift
//  Messenger
//
//  Created by Andrew Turkin on 22.03.18.
//  Copyright © 2018 Andrew Trukin. All rights reserved.
//

import Foundation

struct MessageEntry {
    let text: String
    let id: Int
    let date: Date
}

extension MessageEntry: Hashable {
    var hashValue: Int {
        return id
    }
    
    static func ==(lhs: MessageEntry, rhs: MessageEntry) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MessageEntry: Comparable {
    static func <(lhs: MessageEntry, rhs: MessageEntry) -> Bool {
        return lhs.date < rhs.date
    }
}
