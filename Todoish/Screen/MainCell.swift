//
//  MainCell.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 24/10/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import TinyConstraints


class MainCell: RootCell {
    
    private let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCell() {                
        addSubview(label)
        
        label.widthToSuperview()
        label.heightToSuperview()
        
        label.textColor = .black
        label.textAlignment = .center
    }
    
    func setupData(item: ToDoItem, color: UIColor) {
        label.text = item.getTitle()
        accessoryType = item.getDone() ? .checkmark : .none
        backgroundColor = color
    }
    
    override func prepareForReuse() {
        label.text = ""
        backgroundColor = .clear
    }
}
