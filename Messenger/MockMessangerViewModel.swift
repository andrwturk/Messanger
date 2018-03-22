//
//  MockMessangerViewModel.swift
//  Messenger
//
//  Created by Andrew Turkin on 22.03.18.
//  Copyright © 2018 Andrew Trukin. All rights reserved.
//

import Foundation

class MockMessangerViewModel: MessengerViewModel {
    weak var delegate: MessengerViewModelDelegate?
    
    var dataBinder: MessengerDataBinder = WritingMessengerDataBinder()
    var writingDataBinder: WritingMessengerDataBinder { get{ return dataBinder as! WritingMessengerDataBinder } }
    
    func addMessage(_ message: String) {
        delegate?.viewModelDidStartUpdate(self)
        writingDataBinder.messages += [MessageEntry(text: message, id: 15)]
        delegate?.viewModelDidEndUpdate(self)
    }
    let messsages = (0...100).map({ MessageEntry(text: "asdfkb sdfsdfjksda sdjkfsdj hskjhfkjsahd shdafjhsad dfsgfdsg dfs gfdsgfd s gsfdgsf dg kfs", id: $0) })
    
    func loadMessanges() {
        delegate?.viewModelDidStartUpdate(self)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let messages = (0...100).map({MessageEntry(text: "asdfkb sdfsdfjksda sdjkfsdj hskjhfkjsahd shdafjhsad dfsgfdsg dfs gfdsgfd s gsfdgsf dg kfs", id: $0)})
            self.writingDataBinder.messages = messages
            self.delegate?.viewModelDidEndUpdate(self)
        }
    }
    
    func loadMessagesPage() {
        
    }
}
