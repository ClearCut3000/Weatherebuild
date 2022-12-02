//
//  LightningBolt.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 02.12.2022.
//

import SwiftUI

class LightningBolt {

  //MARK: - Properties
  var points = [CGPoint]()
  var width: Double
  var angle: Double
  
  //MARK: - Init
  init(start: CGPoint, width: Double, angle: Double) {
    points.append(start)
    self.width = width
    self.angle = angle
  }
}
