//
//  TestDetailsView.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 12/11/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import TinyConstraints

class TestDetailsView: UIView {
    
    let label = UILabel()
    
    let button1 = UIButton()
    let button2 = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        addSubview(button1)
        addSubview(button2)
        addSubview(label)
        
        
        label.text = "Choose the color of the tableview"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.topToSuperview(offset: 100)
        label.widthToSuperview(multiplier: 0.7)
        label.centerXToSuperview()
        label.textColor = .white
        
        button1.centerXToSuperview()
        button1.width(100)
        button1.height(50)
        button1.centerYToSuperview(offset: -150)
        
        button2.centerXToSuperview()
        button2.width(100)
        button2.height(50)
        button2.centerYToSuperview(offset: 50)
        
        button1.setTitle("Red", for: UIControl.State.normal)
        button2.setTitle("Purple", for: UIControl.State.normal)

        
        button1.backgroundColor = UIColor.red
        button2.backgroundColor = UIColor.purple
    }

}
