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
  
  // MARK: - UIViewControllerTransitioningDelegate
  
  
}
