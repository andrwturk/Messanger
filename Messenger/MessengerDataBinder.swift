//
//  MessengerDataBinder.swift
//  Messenger
//
//  Created by Andrew Turkin on 22.03.18.
//  Copyright © 2018 Andrew Trukin. All rights reserved.
//

protocol MessengerDataBinder {
    var numberOfRows: Int {get}
    func rowAtIndex(_ index: Int) -> MessengerRowItem
}

class WritingMessengerDataBinder: MessengerDataBinder {
    var messages: [MessageEntry] = []
    var numberOfRows: Int {
        get {
            return messages.count
        }
    }
    
    func rowAtIndex(_ index: Int) -> MessengerRowItem {
        return .Message(messages[index])
    }
}

enum MessengerRowItem {
    case LoadMoreData
    case Message(MessageEntry)
}
