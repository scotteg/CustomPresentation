//
//  AwesomeTransitioner.swift
//  CustomPresentation
//
//  Created by Scott Gardner on 11/5/14.
//  Copyright (c) 2014 Fresh App Factory. All rights reserved.
//

import UIKit

class AwesomeTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
  
  let selectedObject: SelectionObject
  
  init(selectedObject: SelectionObject) {
    self.selectedObject = selectedObject
    super.init()
  }
  
  // MARK: - UIViewControllerTransitioningDelegate
  
  func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
    let presentationController = AwesomePresentationController(presentedViewController: presented, presentingViewController: presenting)
    presentationController.configureWithSelectionObject(selectedObject)
    return presentationController
  }
  
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animationController = AwesomeAnimatedTransitioning(isPresentation: true, selectedObject: selectedObject)
    return animationController
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animationController = AwesomeAnimatedTransitioning(isPresentation: false, selectedObject: selectedObject)
    return animationController
  }
  
}

class AwesomeAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
  
  let isPresentation: Bool
  let selectedObject: SelectionObject
  
  init(isPresentation: Bool, selectedObject: SelectionObject) {
    self.isPresentation = isPresentation
    self.selectedObject = selectedObject
    super.init()
  }
  
  // MARK: - UIViewControllerAnimatedTransitioning
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.7
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
    let fromView = fromViewController.view
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
    let toView = toViewController.view
    let containerView = transitionContext.containerView()
    
    if isPresentation {
      containerView.addSubview(toView)
    }
    
    let animatingViewController = isPresentation ? toViewController : fromViewController
    let animatingView = animatingViewController.view
    animatingView.frame = transitionContext.finalFrameForViewController(animatingViewController)
    let appearedFrame = animatingView.frame
    var dismissedFrame = appearedFrame
    dismissedFrame.origin.y += CGRectGetHeight(dismissedFrame)
    let initialFrame = isPresentation ? dismissedFrame : appearedFrame
    let finalFrame = isPresentation ? appearedFrame : dismissedFrame
    animatingView.frame = initialFrame
    
    var countriesViewController = (isPresentation ? fromViewController : toViewController) as CountriesViewController
    if !isPresentation {
      countriesViewController.hideImage(true, indexPath: selectedObject.selectedCellIndexPath)
    }
    
    UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, options: .AllowUserInteraction | .BeginFromCurrentState, animations: { [unowned self] in
      animatingView.frame = finalFrame
      countriesViewController.changeCellSpacingForPresentation(self.isPresentation)
      }, completion: { [unowned self] _ in
        if !self.isPresentation {
          countriesViewController.hideImage(false, indexPath: self.selectedObject.selectedCellIndexPath)
          UIView.animateWithDuration(0.3, animations: {
            fromView.alpha = 0.0
            }, completion: { _ in
              fromView.removeFromSuperview()
              transitionContext.completeTransition(true)
          })
        } else {
          transitionContext.completeTransition(true)
        }
    })
  }
  
}