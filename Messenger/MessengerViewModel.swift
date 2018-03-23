//
//  MessengerViewModel.swift
//  Messenger
//
//  Created by Andrew Turkin on 22.03.18.
//  Copyright © 2018 Andrew Trukin. All rights reserved.
//

import Foundation

protocol MessengerViewModel {
    func loadMessangesPage()
    func addMessage(_ message: String)
    var dataBinder: MessengerDataBinder {get set}
    weak var delegate: MessengerViewModelDelegate? {get set}
    var pageSize: Int {get}
    func initialize()
    func preventUpdates(_ prevent: Bool)
}

protocol MessengerViewModelDelegate: class {
    func viewModelDidStartUpdate(_ viewModel: MessengerViewModel)
    func viewModelDidEndUpdate(_ viewModel: MessengerViewModel, updateType: MessengerViewModelUpdateType)
}

enum MessengerViewModelUpdateType {
    case Initial
    case NewMessage
    case LoadContent
}
