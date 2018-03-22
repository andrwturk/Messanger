//
//  ViewController.swift
//  Messenger
//
//  Created by Andrew Turkin on 22.03.18.
//  Copyright © 2018 Andrew Trukin. All rights reserved.
//

import UIKit

class MessangerViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: MessengerViewModel = MockMessangerViewModel()
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.delegate = self
        viewModel.loadMessanges()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140.0
        tableView.separatorStyle = .none
        MessageEntryCell.register(forTableView: tableView)
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        if let text = messageTextField.text {
            viewModel.addMessage(text)
            messageTextField.text = nil
        }
    }
}

extension MessangerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.dataBinder.rowAtIndex(indexPath.row) {
        case .Message(let message):
            let cell = MessageEntryCell.deque(forTableView: tableView, atIndexPath: indexPath)
            cell.messageLabel.text = message.text
            return cell
        case .LoadMoreData:
            let cell = MessageEntryCell.deque(forTableView: tableView, atIndexPath: indexPath)
            cell.messageLabel.text = "sadfa"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataBinder.numberOfRows
    }
}

extension MessangerViewController: MessengerViewModelDelegate {
    func viewModelDidStartUpdate(_ viewModel: MessengerViewModel) { }
    
    func viewModelDidEndUpdate(_ viewModel: MessengerViewModel) {
        tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(row: viewModel.dataBinder.numberOfRows-1, section: 0), at: .bottom, animated: true)
        }
    }
}
