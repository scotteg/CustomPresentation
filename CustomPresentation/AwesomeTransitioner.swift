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
    // TODO:
  }
}