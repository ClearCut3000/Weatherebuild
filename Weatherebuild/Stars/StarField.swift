//
//  StarField.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 27.11.2022.
//

import Foundation

class StarField {

  //MARK: - Class Properties
  var stars = [Star]()
  let leftEdge = -50.0
  let rightEdge = 500.0
  var lastUpdate = Date.now

  //MARK: - Class Init
  init() {
    for _ in 1...200 {
      let x = Double.random(in: leftEdge...rightEdge)
      let y = Double.random(in: 0...600)
      let size = Double.random(in: 1...3)
      let star = Star(x: x, y: y, size: size)
      stars.append(star)
    }
  }

  //MARK: - Class Methods
  func update(date: Date) {
    let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970
    for star in stars {
      star.x -= delta * 2
      if star.x < leftEdge {
        star.x = rightEdge
      }
    }
    lastUpdate = date
  }
}
