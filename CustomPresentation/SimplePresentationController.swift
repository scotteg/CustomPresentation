//
//  SimplePresentationController.swift
//  CustomPresentation
//
//  Created by Scott Gardner on 11/2/14.
//  Copyright (c) 2014 Fresh App Factory. All rights reserved.
//

import UIKit

class SimplePresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {
  
  var dimmingView = UIView()
  
  override init(presentedViewController: UIViewController!, presentingViewController: UIViewController!) {
    super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
    dimmingView.alpha = 0.0
  }
  
  override func presentationTransitionWillBegin() {
    dimmingView.frame = containerView.bounds
    dimmingView.alpha = 0.0
    containerView.insertSubview(dimmingView, atIndex: 0)
    let coordinator = presentedViewController.transitionCoordinator()
    if coordinator != nil {
      coordinator?.animateAlongsideTransition({ [unowned self] _ in
        self.dimmingView.alpha = 1.0
      }, completion: nil)
    } else {
      dimmingView.alpha = 1.0
    }
  }
  
  override func dismissalTransitionWillBegin() {
    let coordinator = presentedViewController.transitionCoordinator()
    if coordinator != nil {
      coordinator?.animateAlongsideTransition({ [unowned self] _ in
        self.dimmingView.alpha = 0.0
      }, completion: nil)
    } else {
      dimmingView.alpha = 0.0
    }
  }
  
  override func containerViewWillLayoutSubviews() {
    dimmingView.frame = containerView.bounds
    presentedView().frame = containerView.bounds
  }
  
  override func shouldPresentInFullscreen() -> Bool {
    return true
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
    let animationController = SimpleTransitioner()
    animationController.isPresentation = false
    return animationController
  }
  
  // MARK: - UIAdaptivePresentationControllerDelegate
  
  override func adaptivePresentationStyle() -> UIModalPresentationStyle {
    return .OverFullScreen
  }
  
}
