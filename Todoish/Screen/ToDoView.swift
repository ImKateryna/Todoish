//
//  RootView.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 24/10/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import TinyConstraints

class ToDoView: UIView {
    
    let tableview = UITableView()
    let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .blue
        
        self.addSubview(tableview)
        self.addSubview(searchBar)
        
        searchBar.widthToSuperview()
        searchBar.topToSuperview(offset: 86)
        searchBar.prompt = "Call"
        searchBar.height(80)
       // searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .white
        
        tableview.topToBottom(of: searchBar)
        tableview.bottomToSuperview()
        tableview.widthToSuperview()
        tableview.separatorStyle = .none
        print("TodoView")
        print(tableview.frame)

        
    }

}
