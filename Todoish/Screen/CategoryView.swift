//
//  CategoryView.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 20/11/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import TinyConstraints

class CategoryView: UIView {

    let categoryList = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        addSubview(categoryList)
        
        categoryList.separatorStyle = .none
        
        categoryList.widthToSuperview()
        categoryList.heightToSuperview()
    }

}
