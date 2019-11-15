//
//  TestViewController.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 12/11/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    let presentedYOffset = 150
    var delegate: TestFunctionalityDelegate?
    let myView = TestDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = myView

        myView.backgroundColor = Color.dirtyGray
        
        myView.button1.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.touchUpInside)
        myView.button2.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.touchUpInside)
    }

    
    @objc func buttonPressed(_ sender: UIButton) {
        delegate?.userWantsToChangeColor(color: sender.backgroundColor ?? UIColor.white)
    }
}
