
//
//  ItemCellTableViewCell.swift
//  Todo
//
//  Created by Martin Kelly on 09/11/2017.
//  Copyright © 2017 Scriptable Ltd. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    func configCell(with item: TodoItem, checked: Bool = false) {
        
        if checked {
            let attributedString = NSAttributedString(string: item.title, attributes: [
                NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue
            ])
            
            titleLabel.attributedText = attributedString
            locationLabel.text = nil
            dateLabel.text = nil
        } else {
            titleLabel.text = item.title
            if let timestamp = item.timestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                dateLabel.text = dateFormatter.string(from: date)
            }
            
            if let location = item.location {
                locationLabel.text = location.name
            }
        }
    }
}
