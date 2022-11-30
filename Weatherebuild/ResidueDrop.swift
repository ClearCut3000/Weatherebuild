//
//  ResidueDrop.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 30.11.2022.
//

import SwiftUI

struct ResidueDrop {

  //MARK: - Properties
  var destructionTime: Double
  var x: Double
  var y = 0.5
  var scale: Double
  var speed: Double
  var opacity: Double
  var xMovement: Double
  var yMovement: Double

  //MARK: - Init
  init(type: Storm.Contents, xPosition: Double, destructionTime: Double) {
    self.x = xPosition
    self.destructionTime = destructionTime

    switch type {
    case .snow:
      scale = Double.random(in: 0.125...0.75)
      opacity = Double.random(in: 0.2...0.7)
      speed = 0

      xMovement = 0
      yMovement = 0
    default:
      scale = Double.random(in: 0.4...0.5)
      opacity = Double.random(in: 0...0.3)
      speed = 2

      let direction = Angle.degrees(.random(in: 225...315)).radians
      xMovement = cos(direction)
      yMovement = sin(direction) / 1.5
    }

}
