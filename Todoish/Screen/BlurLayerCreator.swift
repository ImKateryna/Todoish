//
//  BlurLayerCreator.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 31/10/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit

class BlurLayerCreator: UIVisualEffectView {
    
    
    func setupBlur(blurEffect: UIBlurEffect) {
        self.effect = blurEffect
    }
    
    func createOverlayMovingCircleMask(frame: CGRect,
                                       xOffsetFrom: CGFloat,
                                       yOffsetFrom: CGFloat,
                                       xOffsetTo: CGFloat,
                                       yOffsetTo: CGFloat,
                                       radius: CGFloat,
                                       duration: CFTimeInterval) {
        
        let shape = CAShapeLayer()
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: xOffsetFrom, y: yOffsetFrom),
                    radius: radius,
                    startAngle: 0.0,
                    endAngle: 2.0 * .pi,
                    clockwise: false)
        path.addRect(frame)
        
        let newPath = CGMutablePath()
        newPath.addArc(center: CGPoint(x: xOffsetTo, y: yOffsetTo),
                       radius: radius,
                       startAngle: 0.0,
                       endAngle: 2.0 * .pi,
                       clockwise: false)
        newPath.addRect(frame)
        
        shape.path = path
        shape.fillRule = .evenOdd
        
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = newPath
        
        animation.duration = 2
        shape.add(animation, forKey: "Animation")
        self.layer.mask = shape
    }
}
