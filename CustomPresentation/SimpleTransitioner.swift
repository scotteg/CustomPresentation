//
//  SimpleTransitioner.swift
//  CustomPresentation
//
//  Created by Scott Gardner on 11/3/14.
//  Copyright (c) 2014 Fresh App Factory. All rights reserved.
//

import UIKit

class SimpleTransitioner: NSObject, UIViewControllerAnimatedTransitioning {
  var isPresentation = false
  
  // MARK: - UIViewControllerAnimatedTransitioning
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.5
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
    let fromView = fromViewController!.view
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
    let toView = toViewController!.view
    let containerView = transitionContext.containerView()
    if isPresentation {
      containerView.addSubview(toView)
    }
    let animatingViewController = isPresentation ? toViewController : fromViewController
    let animatingView = animatingViewController!.view
    let appearedFrame = transitionContext.finalFrameForViewController(animatingViewController!)
    var dismissedFrame = appearedFrame
    dismissedFrame.origin.y += dismissedFrame.size.height
    let initialFrame = isPresentation ? dismissedFrame : appearedFrame
    let finalFrame = isPresentation ? appearedFrame : dismissedFrame
    animatingView.frame = initialFrame
    UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 300.0, initialSpringVelocity: 5.0, options: .AllowUserInteraction, animations: {
      animatingView.frame = finalFrame
      }, completion: { [unowned self] (value: Bool) in
        if !self.isPresentation {
          fromView.removeFromSuperview()
        }
        transitionContext.completeTransition(true)
    })
  }
  
}

class SimpleTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
  func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
    let presentationController = SimplePresentationController(presentedViewController: presented, presentingViewController: presenting)
    return presentationController
  }
  
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animationController = SimpleTransitioner()
    animationController.isPresentation = true
    return animationController
  }
}