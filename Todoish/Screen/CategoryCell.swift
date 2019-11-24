//
//  MainCell.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 24/10/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import TinyConstraints
import ChameleonFramework

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
    
    func setupData(of categoty: Category?) {
        if let currentCategory = categoty {
            label.text = currentCategory.name
            label.backgroundColor = UIColor(hexString: currentCategory.color) ?? .black
            label.textColor = ContrastColorOf(backgroundColor: label.backgroundColor!, returnFlat: true)
        } else {
            label.text = "No categories added yet"
        }
    }
    
    override func prepareForReuse() {
        label.text = ""
        backgroundColor = .clear
    }
}

