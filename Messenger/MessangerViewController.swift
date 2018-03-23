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
    fileprivate var heightDictionary: [Int : CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.delegate = self
        viewModel.initialize()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        MessageEntryCell.register(forTableView: tableView)
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        if let text = messageTextField.text, !text.isEmpty {
            viewModel.addMessage(text)
            messageTextField.text = nil
        }
    }
}

extension MessangerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        heightDictionary[indexPath.row] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = heightDictionary[indexPath.row]
        return height ?? UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.dataBinder.rowAtIndex(indexPath.row) {
        case .Message(let message):
            let cell = MessageEntryCell.deque(forTableView: tableView, atIndexPath: indexPath)
            cell.messageLabel.text = message.text
            return cell
        case .LoadMoreData:
            let cell = MessageEntryCell.deque(forTableView: tableView, atIndexPath: indexPath)
            cell.messageLabel.text = "Loading..."
            viewModel.loadMessangesPage()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataBinder.numberOfRows
    }
}

extension MessangerViewController: MessengerViewModelDelegate {
    func viewModelDidEndUpdate(_ viewModel: MessengerViewModel, updateType: MessengerViewModelUpdateType) {
        switch updateType {
        case .Initial:
            fallthrough
        case .NewMessage:
            CATransaction.begin()
            viewModel.preventUpdates(true)
            tableView.reloadData()
            CATransaction.setCompletionBlock {
                self.tableView.scrollToRow(at: IndexPath(row: viewModel.dataBinder.numberOfRows-1, section: 0), at: .bottom, animated: true)
                viewModel.preventUpdates(false)
            }
            CATransaction.commit()
        case .LoadContent:
            let previousContentHeight = tableView.contentSize.height
            let previousContentOffset = tableView.contentOffset.y
            tableView.reloadData()
            tableView.layoutIfNeeded()
            let currentContentOffset = tableView.contentSize.height - previousContentHeight
            tableView.contentOffset = CGPoint(x: 0, y: currentContentOffset)
            
        }
    }
    
    func viewModelDidStartUpdate(_ viewModel: MessengerViewModel) { }
}
