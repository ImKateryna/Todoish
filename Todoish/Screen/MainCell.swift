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
        backgroundColor = .green
        
        addSubview(label)
        
        label.widthToSuperview()
        label.heightToSuperview()
        
        label.textColor = .black
        label.textAlignment = .center
    }
    
    func setupData(name: String) {
        label.text = name
    }
    
    override func prepareForReuse() {
        label.text = ""
    }
}
