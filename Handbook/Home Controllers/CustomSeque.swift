//
//  CustomSeque.swift
//  Theatre Suite - Handbook
//
//  Created by Mathew Willett on 8/5/18.
//  Copyright © 2018 Mathew Willett. All rights reserved.
//

import Foundation
import UIKit


//MARK: Custom Seque Setup

class PushPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let operation: UINavigationController.Operation
    
    init(operation: UINavigationController.Operation) {
        self.operation = operation
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let from = transitionContext.viewController(forKey: .from)!
        let to   = transitionContext.viewController(forKey: .to)!
        
        let rightTransform = CGAffineTransform(translationX: transitionContext.containerView.bounds.size.width, y: 0)
        if operation == .push {
            to.view.transform = rightTransform
            transitionContext.containerView.addSubview(to.view)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                to.view.transform = .identity
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else if operation == .pop {
            to.view.transform = .identity
            transitionContext.containerView.insertSubview(to.view, belowSubview: from.view)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                from.view.transform = rightTransform
            }, completion: { finished in
                from.view.transform = .identity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })   
        }
    }
}
