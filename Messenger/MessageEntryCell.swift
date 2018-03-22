//
//  MessageEntryCell.swift
//  Messenger
//
//  Created by Andrew Turkin on 22.03.18.
//  Copyright © 2018 Andrew Trukin. All rights reserved.
//

import UIKit

class MessageEntryCell: UITableViewCell {
    static let ID: String = String(describing: MessageEntryCell.self)
    var messageLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
    }
    
    class func deque(forTableView tableView: UITableView, atIndexPath: IndexPath) -> MessageEntryCell {
        return tableView.dequeueReusableCell(withIdentifier: MessageEntryCell.ID, for: atIndexPath) as! MessageEntryCell
    }
    
    class func register(forTableView tableView: UITableView) {
        tableView.register(MessageEntryCell.self, forCellReuseIdentifier: MessageEntryCell.ID)
    }
}
