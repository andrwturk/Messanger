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
    var pageSize: Int = 30
    var dataBinder: MessengerDataBinder = WritingMessengerDataBinder()
    var writingDataBinder: WritingMessengerDataBinder { get{ return dataBinder as! WritingMessengerDataBinder } }
    let messsages = (0..<100).map({ MessageEntry(text: "\($0) asdfkb sdfsdfjksda sdjkfsdj hskjhfkjsahd shdafjhsad dfsgfdsg dfs gfdsgfd s gsfdgsf dg kfs", id: $0, date: Date()) })
    var preventUpdates: Bool = false
    
    func preventUpdates(_ prevent: Bool) {
        preventUpdates = prevent
    }
    
    func addMessage(_ message: String) {
        delegate?.viewModelDidStartUpdate(self)
        writingDataBinder.messages.insert(MessageEntry(text: message, id: writingDataBinder.messages.count, date: Date()))
        delegate?.viewModelDidEndUpdate(self, updateType: .NewMessage)
    }
    
    func loadMessangesPage() {
        if preventUpdates { return }
        delegate?.viewModelDidStartUpdate(self)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let updateType: MessengerViewModelUpdateType = self.writingDataBinder.messages.count == 0 ? .Initial : .LoadContent
            self.writingDataBinder.union( Array(self.messsages[max(0, self.messsages.count - (self.writingDataBinder.messages.count + self.pageSize))..<self.messsages.count]) )
            self.writingDataBinder.moreDataAvailable = self.writingDataBinder.messages.count < self.messsages.count
            self.delegate?.viewModelDidEndUpdate(self, updateType: updateType)
        }
    }
    
    func initialize() {
        delegate?.viewModelDidStartUpdate(self)
        writingDataBinder.moreDataAvailable = true
        delegate?.viewModelDidEndUpdate(self, updateType: .LoadContent)
    }
}
