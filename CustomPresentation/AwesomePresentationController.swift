//
//  AwesomePresentationController.swift
//  CustomPresentation
//
//  Created by Scott Gardner on 11/4/14.
//  Copyright (c) 2014 Fresh App Factory. All rights reserved.
//

import UIKit

class AwesomePresentationController: UIPresentationController, UIViewControllerTransitioningDelegate {
  
  let dimmingView = UIView()
  let flagImageView =  UIImageView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 160.0, height: 93.0)))
  var selectionObject: SelectionObject?
  var isAnimating = false
  
  override init(presentedViewController: UIViewController!, presentingViewController: UIViewController!) {
    super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    dimmingView.backgroundColor = UIColor.clearColor()
    flagImageView.contentMode = .ScaleAspectFill
    flagImageView.clipsToBounds = true
    flagImageView.layer.cornerRadius = 4.0
  }
  
  func configureWithSelectionObject(selectionObject: SelectionObject) {
    self.selectionObject = selectionObject
    let image = UIImage(named: selectionObject.country.imageName)
    flagImageView.image = image
    flagImageView.frame = selectionObject.originalCellPosition
  }
  
  func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
    return .OverFullScreen
  }
  
  override func frameOfPresentedViewInContainerView() -> CGRect {
    return containerView.bounds
  }
  
  override func containerViewWillLayoutSubviews() {
    dimmingView.frame = containerView.bounds
    presentedView().frame = containerView.bounds
  }
  
  func scaleAndPositionFlag() {
    var flagFrame = flagImageView.frame
    let containerFrame = containerView.frame
    var originYMultiplier = 0.0 as CGFloat
    let cellSize = selectionObject!.originalCellPosition.size
    var flagFrameMultiplier = 0.0 as CGFloat
    
    if CGRectGetWidth(containerFrame) > CGRectGetWidth(containerFrame) {
      flagFrameMultiplier = 1.5
      originYMultiplier = 0.25
    } else {
      flagFrameMultiplier = 1.8
      originYMultiplier = 0.333
    }
    
    flagFrame.size.width = cellSize.width * flagFrameMultiplier
    flagFrame.size.height = cellSize.height * flagFrameMultiplier
    flagFrame.origin.x = CGRectGetWidth(containerFrame) / 2 - CGRectGetWidth(flagFrame) / 2
    flagFrame.origin.y = CGRectGetHeight(containerFrame) * originYMultiplier - CGRectGetHeight(flagFrame) / 2
    flagImageView.frame = flagFrame
  }
  
  func moveFlagToPresentedPosition(presentedPosition: Bool) {
    if presentedPosition {
      scaleAndPositionFlag()
    } else {
      flagImageView.frame = selectionObject!.originalCellPosition
    }
  }
  
  func animateFlagToPresentedPosition(presentedPosition: Bool) {
    let coordinator = presentedViewController.transitionCoordinator()!
    coordinator.animateAlongsideTransition({ [unowned self] _ in
      self.moveFlagToPresentedPosition(presentedPosition)
      }, completion: { [unowned self] _ in
        self.isAnimating = false
    })
  }
  
  override func presentationTransitionWillBegin() {
    super.presentationTransitionWillBegin()
    isAnimating = true
    moveFlagToPresentedPosition(false)
    dimmingView.addSubview(flagImageView)
    containerView.addSubview(dimmingView)
    animateFlagToPresentedPosition(true)
  }
  
  override func dismissalTransitionWillBegin() {
    super.dismissalTransitionWillBegin()
    isAnimating = true
    animateFlagToPresentedPosition(false)
  }
  
}
