//
//  InteractiveModalPresentationController.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 12/11/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import CoreGraphics

enum ModalScaleState {
    case presentation
    case interaction
}

class InteractiveModalPresentationController: UIPresentationController {
    
    private let presentedXOffset: CGFloat = UIScreen.main.bounds.width / 2
    private var direction: CGFloat = 0
    private var state: ModalScaleState = .interaction
    private lazy var dimmingView: UIView! = {
        guard let container = containerView else { return nil }
        
        let view = UIView(frame: container.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(didTap(tap:)))
        )
        
        return view
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        presentedViewController.view.addGestureRecognizer(
            UIPanGestureRecognizer(target: self, action: #selector(didPan(pan:)))
        )
    }
    
    @objc func didPan(pan: UIPanGestureRecognizer) {
        guard let view = pan.view, let superView = view.superview,
            let presented = presentedView, let container = containerView else { return }
        
        let location = pan.translation(in: superView)
        
        print("location: \(location)")
        print("container: w = \(container.frame.width), h = \(container.frame.height)")
        
        switch pan.state {
        case .began:
            print("case: began")
            presented.frame.size.height = container.frame.height
        case .changed:
            print("case: changed")
            let velocity = pan.velocity(in: superView)
            print("velocity: \(velocity)")
            
            
            switch state {
            case .interaction:
                print("case: interaction")
                presented.frame.origin.x = location.x + presentedXOffset
            case .presentation:
                print("case: presentation")
                presented.frame.origin.x = location.x
            }
            direction = velocity.x
        case .ended:
            print("case: ended")
            let maxPresentedX = container.frame.width - presentedXOffset
            switch presented.frame.origin.x {
            case 0...maxPresentedX:
                print("case: maxX")
                changeScale(to: .interaction)
            default:
                print("case: default")
                let transition = CATransition()
                transition.duration = 3
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromLeft
                presentedViewController.view.layer.add(transition, forKey: nil)
                presentedViewController.dismiss(animated: false, completion: nil)
                //presentedViewController.dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    @objc func didTap(tap: UITapGestureRecognizer) {
        print("did didTap to dissmiss")
        //presentedViewController.dismiss(animated: true, completion: nil)
        let transition = CATransition()
        transition.duration = 3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        presentedViewController.view.layer.add(transition, forKey: nil)
        presentedViewController.dismiss(animated: false, completion: nil)
    }
    
    func changeScale(to state: ModalScaleState) {
        guard let presented = presentedView else { return }
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [weak self] in
            guard let `self` = self else { return }
            
            presented.frame = self.frameOfPresentedViewInContainerView
            
            }, completion: { (isFinished) in
                self.state = state
        })
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let container = containerView else { return .zero }
        
        return CGRect(x: self.presentedXOffset, y: 0, width: container.bounds.width - self.presentedXOffset, height: container.bounds.height)
    }
    
    override func presentationTransitionWillBegin() {
        guard let container = containerView,
            let coordinator = presentingViewController.transitionCoordinator else { return }
        
        dimmingView.alpha = 0
        container.addSubview(dimmingView)
        dimmingView.addSubview(presentedViewController.view)
        
        coordinator.animate(alongsideTransition: { [weak self] context in
            guard let `self` = self else { return }
            
            self.dimmingView.alpha = 1
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator else { return }
        
        coordinator.animate(alongsideTransition: { [weak self] (context) -> Void in
            guard let `self` = self else { return }
            
            self.dimmingView.alpha = 0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
    
}
