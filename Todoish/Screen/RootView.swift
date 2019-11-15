//
//  RootView.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 24/10/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import TinyConstraints

class RootView: UIView {
    
    let myList = UITableView()
    let label = UILabel()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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
        
        self.addSubview(myList)
        self.addSubview(label)
        
        myList.heightToSuperview()
        myList.widthToSuperview()
        myList.separatorStyle = .none
        
        
        label.text = "TestDetailsVC"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        label.bottomToSuperview(offset: -20)
        label.centerXToSuperview()
        label.isUserInteractionEnabled = true
        
//        let shape = CAShapeLayer()
//        self.layer.addSublayer(shape)
//        
//        shape.strokeColor = UIColor.white.cgColor
//        shape.fillColor = UIColor.blue.cgColor
//        
//        let screenSize = UIScreen.main.bounds
//        
//        let path = CGMutablePath()
//        
//        path.addArc(center: CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2),
//                    radius: 50,
//                    startAngle: CGFloat(0),
//                    endAngle: CGFloat(Float.pi * 2),
//                    clockwise: true)
//         
//        document.path = path
    }

}
