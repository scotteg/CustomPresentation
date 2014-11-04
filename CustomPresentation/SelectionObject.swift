//
//  SelectionObject.swift
//  CustomPresentation
//
//  Created by Scott Gardner on 11/4/14.
//  Copyright (c) 2014 Fresh App Factory. All rights reserved.
//

import UIKit

class SelectionObject: NSObject {
  
  var originalCellPosition: CGRect
  var country: Country
  var selectedCellIndexPath: NSIndexPath
  
  init(country: Country, selectedCellIndexPath: NSIndexPath, originalCellPosition: CGRect) {
    self.country = country
    self.selectedCellIndexPath = selectedCellIndexPath
    self.originalCellPosition = originalCellPosition
  }
}
