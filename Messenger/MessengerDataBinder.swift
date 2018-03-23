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
    var messages: Set<MessageEntry> = Set<MessageEntry>()
    var moreDataAvailable: Bool = false
    
    var numberOfRows: Int {
        get {
            return moreDataAvailable ? messages.count + 1 :
                                       messages.count
        }
    }
    
    func rowAtIndex(_ index: Int) -> MessengerRowItem {
        if index == 0 && moreDataAvailable {
            return .LoadMoreData
        }
        else {
            // translate index
            var newIndex = index
            if moreDataAvailable {
                newIndex -= 1
            }
            return .Message(messages.sorted()[newIndex])
        }
    }

    func union(_ newMessages: [MessageEntry]) {
        messages = Set(newMessages).union(messages)
    }
}

enum MessengerRowItem {
    case LoadMoreData
    case Message(MessageEntry)
}
