//
//  MessengerViewModel.swift
//  Messenger
//
//  Created by Andrew Turkin on 22.03.18.
//  Copyright © 2018 Andrew Trukin. All rights reserved.
//

import Foundation

protocol MessengerViewModel {
    func loadMessanges()
    func addMessage(_ message: String)
    var dataBinder: MessengerDataBinder {get set}
    weak var delegate: MessengerViewModelDelegate? {get set}
}

protocol MessengerViewModelDelegate: class {
    func viewModelDidStartUpdate(_ viewModel: MessengerViewModel)
    func viewModelDidEndUpdate(_ viewModel: MessengerViewModel)
}
