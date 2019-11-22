//
//  MainCell.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 24/10/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import TinyConstraints


class CategoryCell: RootCell {
    
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
        
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy)
        label.textAlignment = .center
    }
    
    func setupData(name: String, color: UIColor) {
        label.text = name
        label.textColor = color
    }
    
    override func prepareForReuse() {
        label.text = ""
        backgroundColor = .clear
    }
}
